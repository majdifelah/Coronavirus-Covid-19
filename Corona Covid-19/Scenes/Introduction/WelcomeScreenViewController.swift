//
//  WelcomeScreenViewController.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 11/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAndShowIntroduction()
        
    }
}

func checkAndShowIntroduction() {
    //let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
    let main = UIStoryboard(name: "Main", bundle: nil)
    let isTutorialSceneShown = UserDefaults.standard.bool(forKey: "TutorialScreenShow")
    
    if !isTutorialSceneShown {
        let tutoriaPageVC = main.instantiateViewController(withIdentifier: "introductionScreen")
        
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: tutoriaPageVC)
        
    } else {
        let homeVC = main.instantiateViewController(withIdentifier: "liveCases")
//        appDelegate.window?.rootViewController = UINavigationController(rootViewController: homeVC)
        
        sceneDelegate.window?.rootViewController = UINavigationController(rootViewController: homeVC)
    }
}
