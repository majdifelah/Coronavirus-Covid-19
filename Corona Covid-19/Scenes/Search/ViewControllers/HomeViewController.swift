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
    @IBOutlet weak var checkByCountryButton: UIButton!
    @IBOutlet weak var fatalityRateLabel: UILabel!
    
    @IBOutlet weak var totalCasesView: UIView!
    @IBOutlet weak var totalDeathView: UIView!
    @IBOutlet weak var newDeathsView: UIView!
    @IBOutlet weak var newCasesView: UIView!
    @IBOutlet weak var recoveredView: UIView!
    @IBOutlet weak var fatalityRteView: UIView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    var timer = Timer()
    private var homeListVM: HomeViewModel!
    
    let provider = MoyaProvider<CoronaVirus>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalCasesView.layer.cornerRadius = 15.0
        totalDeathView.layer.cornerRadius = 15.0
        newDeathsView.layer.cornerRadius = 15.0
        newCasesView.layer.cornerRadius = 15.0
        fatalityRteView.layer.cornerRadius = 15.0
        recoveredView.layer.cornerRadius = 15.0
        view.backgroundColor = UIColor(rgb: 0x3C3B3B)

        
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
               //         self.totalDeathsLabel.text = self.homeListVM.totalDeaths
                         self.totalRecoveredLabel.text = self.homeListVM.totalRecovered
                        self.newCasesLabel.text = self.homeListVM.newCases
                        self.newDeathsCases.text = self.homeListVM.newDeaths
                        self.fatalityRateLabel.text = self.homeListVM.fatalityRate
                        
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
