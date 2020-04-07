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

class HomeViewController: UIViewController {
    
    @IBOutlet weak var totalCasesLabel: UILabel!
    @IBOutlet weak var totalDeathsLabel: UILabel!
    @IBOutlet weak var totalRecoveredLabel: UILabel!
    @IBOutlet weak var newCasesLabel: UILabel!
    @IBOutlet weak var newDeathsCases: UILabel!
    
    
    private var homeListVM: HomeViewModel!
    
    let provider = MoyaProvider<CoronaVirus>()
   // var worldStats: WorldStats?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            self.getWorldStats()
        
    }
    
    func getWorldStats() {
        
        self.provider.request(.getWorldStat) {[weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                let data = response.data
                do {
                    let result = try decoder.decode(WorldStats.self, from: data)
                    self.homeListVM = HomeViewModel(result)
                    
                    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    DispatchQueue.main.async {
                    self.totalCasesLabel.text = "Total Cases: \(self.homeListVM.totalCases)"
                             self.totalDeathsLabel.text = "Total Deaths: \(self.homeListVM.totalDeaths)"
                             self.totalRecoveredLabel.text = "Total Recovered: \(self.homeListVM.totalRecovered)"
                             self.newCasesLabel.text = "\(self.homeListVM.newCases)"
                             self.newDeathsCases.text = "\(self.homeListVM.newDeaths)"
                       
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
