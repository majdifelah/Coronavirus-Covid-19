//
//  SearchViewController.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 30/03/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import UIKit
import Foundation
import Moya
import MBProgressHUD
import Charts
import FittedSheets

class SearchViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var countrySearchBar: UISearchBar!
    @IBOutlet weak var countriesTextField: UITextField!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var confirmedCases: UILabel!
    @IBOutlet weak var deaths: UILabel!
    @IBOutlet weak var recovered: UILabel!
    @IBOutlet weak var newCases: UILabel!
    @IBOutlet weak var activeCases: UILabel!
    @IBOutlet weak var newDeaths: UILabel!
    //@IBOutlet weak var seriousCritical: UILabel!
    @IBOutlet weak var confirmedCasesView: UIView!
    @IBOutlet weak var deathsView: UIView!
    @IBOutlet weak var recoveredView: UIView!
    @IBOutlet weak var newCasesView: UIView!
    @IBOutlet weak var activeCasesView: UIView!
    @IBOutlet weak var newDeathsView: UIView!
    
    var countryCovidStat: LatestStatByCountry?

    private var searchVM: SearchViewModel!
    let provider = MoyaProvider<CoronaVirus>()
    let decoder = JSONDecoder()
    var countriesAffected: [String] = []
    var selectedCountry: String?
    var numberOfTypeOfCases = [PieChartDataEntry]()
    
    @IBAction func reloadButtonAction(_ sender: Any) {
        guard let countryToCheck = self.selectedCountry else {return}
        searchForCovidInCountry(countryToCheck)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.confirmedCasesView.layer.cornerRadius = 15
        self.newCasesView.layer.cornerRadius = 15
        self.deathsView.layer.cornerRadius = 15
        self.newDeathsView.layer.cornerRadius = 15
        self.recoveredView.layer.cornerRadius = 15
        self.activeCasesView.layer.cornerRadius = 15
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAffectedCountries()
        createCountriesPickerView()
        createToolBar()
    }
    
    func searchForCovidInCountry(_ country: String) {
        
        self.provider.request(.latestStatByCountry(country: country)) {[weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                let data = response.data
                do {
                    
                    let result = try self.decoder.decode(CountryLiveStats.self, from: data)
                    guard let countryCovidStat =  result.latestStatByCountry.first else {return}
                    self.countryCovidStat = countryCovidStat
                    self.searchVM = SearchViewModel(countryCovidStat)
                    
                    self.setupChart()
                    
                    DispatchQueue.main.async {
                        self.confirmedCases.text = "\(self.searchVM.totalCases)"
                        self.deaths.text = "\(self.searchVM.totalDeaths)"
                        self.recovered.text = "\(self.searchVM.totalRecovered)"
                        self.newCases.text = "\(self.searchVM.newCases)"
                        self.activeCases.text = "\(self.searchVM.activeCases)"
                        self.newDeaths.text = "\(self.searchVM.newDeaths)"
                        //self.seriousCritical.text = "\(self.searchVM.seriousCritical)"
                        self.setupChart()
                    }
                    hud.hide(animated: true)
                } catch {
                    
                    fatalError("fatal error while getting world Stats")
                }
            case .failure(let error):
                fatalError("\(String(describing: error.errorDescription!))")
            }
        }
    }
    
    func getAffectedCountries() {
        self.provider.request(.affectedCoutries) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let response):
                let data = response.data
                do {
                    let result = try self.decoder.decode(AffectedCountries.self, from: data)
                    self.countriesAffected = result.affectedCountries
                } catch {
                    
                    fatalError("fatal error while getting world Stats")
                }
            case .failure(let error):
                fatalError("\(String(describing: error.errorDescription!))")
            }
        }
    }
}

// MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBartext = countrySearchBar.text else { return }
        searchForCovidInCountry(searchBartext.capitalized)
        searchBar.resignFirstResponder()
    }
}

//MARK:Creation of PickerView
extension SearchViewController {
    func createCountriesPickerView() {
        let countriesPickerView = UIPickerView()
        countriesPickerView.delegate = self
        
        countriesTextField.inputView = countriesPickerView
    }
    
    func createToolBar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.tintColor = .black
        
        let searchButton = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(SearchViewController.dismissKeyboard))
        
        toolBar.setItems([searchButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        countriesTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        
        searchForCovidInCountry(selectedCountry ?? "")
        view.endEditing(true)
        
    }
}

//MARK: Picker View Data Source and Delegate
extension SearchViewController: UIPickerViewDataSource,UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.countriesAffected.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let sortedCountries = countriesAffected.sorted()
        return sortedCountries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let sortedCountries = countriesAffected.sorted()
        selectedCountry = sortedCountries[row]
        countriesTextField.text = selectedCountry
    }
}

//MARK: - Chart View
extension SearchViewController {
    
    func setupChart() {
        
        let doubleTotalCases = Double(self.countryCovidStat!.totalCases.replacingOccurrences(of: ",", with: "")) ?? 0.0
        let doubleTotalDeaths = Double(self.countryCovidStat!.totalDeaths.replacingOccurrences(of: ",", with: "")) ?? 0.0
        let doubleTotalRecovered = Double(self.countryCovidStat!.totalRecovered.replacingOccurrences(of: ",", with: "")) ?? 0.0
        pieChartView.chartDescription?.text = "Covid-19 Chart"
        
        let totalCasesDataEntry = PieChartDataEntry(value: 0)
        let deathDataEntry = PieChartDataEntry(value: 0)
        let recoveredDataEntry = PieChartDataEntry(value: 0)
        
        
        totalCasesDataEntry.value = doubleTotalCases
        totalCasesDataEntry.label = "Confirmed"
        deathDataEntry.value = doubleTotalDeaths
        deathDataEntry.label = "Deaths"
        recoveredDataEntry.value = doubleTotalRecovered
        recoveredDataEntry.label = "Recovered"
        numberOfTypeOfCases = [totalCasesDataEntry, deathDataEntry, recoveredDataEntry]
        
        updateChartData()
    }
    
    func updateChartData() {
        let chartDataSet = PieChartDataSet(entries: numberOfTypeOfCases, label: nil)
        let chartData = PieChartData(dataSet: chartDataSet)
        
        let colors = [UIColor(rgb: 0xF6C667), UIColor(rgb: 0xFF7A8A), UIColor(rgb: 0x2A9D8F)]
        chartDataSet.colors = colors
        
        pieChartView.data = chartData
    }
}
