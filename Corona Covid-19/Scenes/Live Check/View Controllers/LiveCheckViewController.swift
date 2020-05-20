//
//  LiveCheckViewController.swift
//  Corona Covid-19
//
//  Created by Emil Vaklinov on 07/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import UIKit
import WebKit
import MBProgressHUD

class LiveCheckViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var symptomsView: WKWebView!

    override func loadView() {
        symptomsView = WKWebView().self
        symptomsView.navigationDelegate = self
        view = symptomsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        
        let url = URL(string: "https://www.nhs.uk/conditions/coronavirus-covid-19/symptoms-and-what-to-do/")!
        hud.hide(animated: true)
        symptomsView.load(URLRequest(url: url))
        symptomsView.allowsBackForwardNavigationGestures = true
        
    }
}

