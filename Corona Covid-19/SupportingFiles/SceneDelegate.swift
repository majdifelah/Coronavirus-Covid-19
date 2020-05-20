//
//  SceneDelegate.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 30/03/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, UITabBarControllerDelegate {
    
    var window: UIWindow?
    let tabBarController = UITabBarController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
    }
    
    func applicationLaunching(withVC: Int) {
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let homeNC = main.instantiateViewController(withIdentifier: "liveCasesNC") as! UINavigationController
        homeNC.pushViewController(main.instantiateViewController(withIdentifier: "liveCasesVC"),animated: true)
        //let symptomsVC = UINavigationController(rootViewController:main.instantiateViewController(withIdentifier: "symptomsVC"))
        let advicesNC = main.instantiateViewController(withIdentifier: "advicesNC") as! UINavigationController
        advicesNC.pushViewController(main.instantiateViewController(withIdentifier: "advicesVC"), animated: true)
        let liveCheckNC = main.instantiateViewController(withIdentifier: "liveCheckNC") as! UINavigationController
        liveCheckNC.pushViewController(main.instantiateViewController(withIdentifier: "liveCheck"), animated: true)
        let testBookingNC = main.instantiateViewController(withIdentifier: "testBookingNC") as! UINavigationController
        testBookingNC.pushViewController(main.instantiateViewController(withIdentifier:"testBookingVC"), animated: true)
        
        self.tabBarController.delegate = self
        
        self.tabBarController.viewControllers = [homeNC, advicesNC, liveCheckNC, testBookingNC]
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        tabBarController.selectedIndex = withVC
        
    }
}
