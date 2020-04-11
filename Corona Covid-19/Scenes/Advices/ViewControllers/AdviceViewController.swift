//
//  AdviceViewController.swift
//  Corona Covid-19
//
//  Created by Emil Vaklinov on 07/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import UIKit
import Moya
import MBProgressHUD

class AdviceViewController: UIViewController {

    @IBOutlet weak var downloadingImage: UIImageView!
    @IBOutlet weak var adviceButton: UIButton!
    @IBOutlet weak var whosVulnerableButton: UIButton!
    
    let provider = MoyaProvider<CoronaVirus>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        adviceButton.layer.cornerRadius = 15.0
        whosVulnerableButton.layer.cornerRadius = 15.0
        
    }
    

  
    func getImage() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        self.provider.request(.randomMaskUsageInstructions) {[weak self] result in
            guard let self = self else { return }
            hud.hide(animated: true)
            switch result {
            case .success(let response):
                let data = response.data
                self.downloadingImage.image = UIImage(data: data)
            case .failure(let error):
                fatalError("\(String(describing: error.errorDescription!))")
            }
            
        }
    }
}
