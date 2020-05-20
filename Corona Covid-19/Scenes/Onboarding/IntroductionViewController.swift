//
//  IntroductionViewController.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 11/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import UIKit

class IntroductionViewController: UIViewController {
    
    @IBOutlet weak var welcomeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.welcomeButton.layer.cornerRadius = 15.0
        
        
    }
    
    @IBAction func welcomeButtonAction(_ sender: Any) {
        
        //Set user defaults
        UserDefaults.standard.set(true, forKey: "onBoarding")
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
          return
        }
        sceneDelegate.applicationLaunching(withVC: 0)
        
    }
}
