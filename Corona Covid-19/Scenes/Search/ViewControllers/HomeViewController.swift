//
//  HomeViewController.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 07/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import UIKit
import Moya
import MBProgressHUD
import Charts

class HomeViewController: UIViewController {
    
    @IBOutlet weak var totalCasesLabel: UILabel!
    @IBOutlet weak var totalDeathsLabel: UILabel!
    @IBOutlet weak var totalRecoveredLabel: UILabel!
    @IBOutlet weak var newCasesLabel: UILabel!
    @IBOutlet weak var newDeathsCases: UILabel!
    @IBOutlet weak var checkByCountryButton: UIButton!
    @IBOutlet weak var fatalityRateLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var totalCasesView: UIView!
    @IBOutlet weak var totalDeathView: UIView!
    @IBOutlet weak var newDeathsView: UIView!
    @IBOutlet weak var newCasesView: UIView!
    @IBOutlet weak var recoveredView: UIView!
    @IBOutlet weak var fatalityRteView: UIView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    var timer = Timer()
    private var homeListVM: HomeViewModel!
    var numberOfTypeOfCases = [PieChartDataEntry]()
    let provider = MoyaProvider<CoronaVirus>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.totalCasesView.layer.cornerRadius = 15.0
        self.totalDeathView.layer.cornerRadius = 15.0
        self.newDeathsView.layer.cornerRadius = 15.0
        self.newCasesView.layer.cornerRadius = 15.0
        self.fatalityRteView.layer.cornerRadius = 15.0
        self.recoveredView.layer.cornerRadius = 15.0
        self.checkByCountryButton.layer.cornerRadius = 15
        
    }
    
    @objc func tick() {
        currentTimeLabel.text = DateFormatter.localizedString(from: Date(),
                                                              dateStyle: .medium,
                                                              timeStyle: .medium)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getWorldStats()
        // self.tick()
        
    }
    
    func getWorldStats() {
        
        self.provider.request(.getWorldStat) {[weak self] result in
            
            guard let self = self else { return }
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                let data = response.data
                
                do {
                    let result = try decoder.decode(WorldStats.self, from: data)
                    self.homeListVM = HomeViewModel(result)
                    DispatchQueue.main.async {
                        self.totalCasesLabel.text = self.homeListVM.totalCases
                        self.totalDeathsLabel.text = self.homeListVM.totalDeaths
                        self.totalRecoveredLabel.text = self.homeListVM.totalRecovered
                        self.newCasesLabel.text = self.homeListVM.newCases
                        self.newDeathsCases.text = self.homeListVM.newDeaths
                        self.fatalityRateLabel.text = self.homeListVM.fatalityRate
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
    
}

extension HomeViewController {
    
    func setupChart() {
        
        let doubleTotalCases = Double(self.homeListVM!.totalCases.replacingOccurrences(of: ",", with: "")) ?? 0.0
        let doubleTotalDeaths = Double(self.homeListVM!.totalDeaths.replacingOccurrences(of: ",", with: "")) ?? 0.0
        let doubleTotalRecovered = Double(self.homeListVM!.totalRecovered.replacingOccurrences(of: ",", with: "")) ?? 0.0
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
