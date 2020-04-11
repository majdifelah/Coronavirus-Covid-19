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
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        let main = UIStoryboard(name: "Main", bundle: nil)
        UserDefaults.standard.set(true, forKey: "TutorialScreenShowed")
        
        sceneDelegate.applicationLaunching(withVC: 0)
//        let homeVC = main.instantiateViewController(withIdentifier: "liveCasesVC")
//        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: homeVC)
    }
}
