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
    let provider = MoyaProvider<CoronaVirus>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImage()
        // Do any additional setup after loading the view.
    }
    

  
    func getImage() {
        
        self.provider.request(.randomMaskUsageInstructions) {[weak self] result in
            guard let self = self else { return }
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            switch result {
            case .success(let response):
                
                let data = response.data
                self.downloadingImage.image = UIImage(data: data)
                hud.hide(animated: true)
            case .failure(let error):
                fatalError("\(String(describing: error.errorDescription!))")
            }
            
        }
    }
}
