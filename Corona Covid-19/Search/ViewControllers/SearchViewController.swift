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

class SearchViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var countrySearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var countriesTextField: UITextField!
     @IBOutlet weak var pieChartView: PieChartView!
    
    private var searchListVM: SearchListViewModel!
    let provider = MoyaProvider<CoronaVirus>()
    let apiManager = APIManager()
    var countryCovidStat: [LatestStatByCountry] = []
    var countriesAffected: [String] = []
    var selectedCountry: String?
    var numberOfTypeOfCases = [PieChartDataEntry]()
    
    @IBAction func reloadButtonAction(_ sender: Any) {
        guard let countryToCheck = self.selectedCountry else {return}
        
        searchForCovidInCountry(countryToCheck)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAffectedCountries()
        createCountriesPickerView()
        createToolBar()
       
    }
    
    func searchForCovidInCountry(_ country: String) {
        
        self.provider.request(.latestStatByCountry(country: country)) {[weak self] result in
            //memory management
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                let data = response.data
                do {
                    let result = try decoder.decode(CountryLiveStats.self, from: data)
                    self.countryCovidStat = result.latestStatByCountry
                    self.searchListVM = SearchListViewModel(countryCovidStats: self.countryCovidStat)
                    self.cleanString()
                    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        ////////////////////////
                        self.cleanString()
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
                let decoder = JSONDecoder()
                let data = response.data
                do {
                    let result = try decoder.decode(AffectedCountries.self, from: data)
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
//MARK: Table View Data Source:
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchListVM == nil ? 0 : self.searchListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchID", for: indexPath) as? SearchTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        
        let searchVM = self.searchListVM.searchStatAtIndex(indexPath.row)
        cell.configureCell(countryCovidStat: searchVM)
        return cell
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
        return countriesAffected[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = countriesAffected[row]
        countriesTextField.text = selectedCountry
    }
}

//MARK: Chart View
extension SearchViewController {
//    var circleChart: PieChartView
    
    
    func setChart(dataPoints: [String], values: [Double]) {

    var dataEntries: [ChartDataEntry] = []

    for i in 0..<dataPoints.count {
        let dataEntry1 = PieChartDataEntry(value: Double(i), label: dataPoints[i], data:  dataPoints[i] as AnyObject)
        dataEntries.append(dataEntry1)
    }
    print(dataEntries[0].data)
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
    let pieChartData = PieChartData(dataSet: pieChartDataSet)
    pieChartView.data = pieChartData

    var colors: [UIColor] = []

    for _ in 0..<dataPoints.count {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))

        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
    }

    pieChartDataSet.colors = colors
    }
}

extension SearchViewController {
    func cleanString() {
    
        let doubleTotalCases = Double(self.countryCovidStat[0].totalCases.replacingOccurrences(of: ",", with: "")) ?? 0.0
        let doubleTotalDeaths = Double(self.countryCovidStat[0].totalDeaths.replacingOccurrences(of: ",", with: "")) ?? 0.0
        let doubleTotalRecovered = Double(self.countryCovidStat[0].totalRecovered.replacingOccurrences(of: ",", with: "")) ?? 0.0
        pieChartView.chartDescription?.text = "Covid-19 Chart"
        
        var totalCasesDataEntry = PieChartDataEntry(value: 0)
        var deathDataEntry = PieChartDataEntry(value: 0)
        var recoveredDataEntry = PieChartDataEntry(value: 0)
        
        
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

