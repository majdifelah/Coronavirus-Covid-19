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
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    var menuViewController: MenuViewController!
    var visualEffectView:UIVisualEffectView!
    let cardHeight:CGFloat = 600
    let cardHandleAreaHeight:CGFloat = 65
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    private var searchListVM: SearchListViewModel!
    let provider = MoyaProvider<CoronaVirus>()
    let decoder = JSONDecoder()
    var countryCovidStat: [LatestStatByCountry] = []
    var countriesAffected: [String] = []
    var selectedCountry: String?
    var numberOfTypeOfCases = [PieChartDataEntry]()
    
    @IBAction func reloadButtonAction(_ sender: Any) {
        guard let countryToCheck = self.selectedCountry else {return}
        
        searchForCovidInCountry(countryToCheck)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupCard()
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
                let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                let data = response.data
                do {
                    
                    let result = try self.decoder.decode(CountryLiveStats.self, from: data)
                    self.countryCovidStat = result.latestStatByCountry
                    self.searchListVM = SearchListViewModel(countryCovidStats: self.countryCovidStat)
                    self.setupChart()
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
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

//MARK: Chart View
extension SearchViewController {
    func setupChart() {
        
        let doubleTotalCases = Double(self.countryCovidStat[0].totalCases.replacingOccurrences(of: ",", with: "")) ?? 0.0
        let doubleTotalDeaths = Double(self.countryCovidStat[0].totalDeaths.replacingOccurrences(of: ",", with: "")) ?? 0.0
        let doubleTotalRecovered = Double(self.countryCovidStat[0].totalRecovered.replacingOccurrences(of: ",", with: "")) ?? 0.0
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

//Mark: Creation of menu view
extension SearchViewController {
    
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        menuViewController = MenuViewController(nibName:"MainCard", bundle:nil)
        self.addChild(menuViewController)
        self.view.addSubview(menuViewController.view)
        
        menuViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        
        menuViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(SearchViewController.handleCardPan(recognizer:)))
        
        menuViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        menuViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc
    func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.menuViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
        default:
            break
        }
    }
    
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.menuViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.menuViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.menuViewController.view.layer.cornerRadius = 12
                case .collapsed:
                    self.menuViewController.view.layer.cornerRadius = 0
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
            
        }
    }
    
    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}

