//
//  SymptomsViewController.swift
//  Corona Covid-19
//
//  Created by Emil Vaklinov on 07/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import UIKit
import WebKit


class SymptomsViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet var symptomsView: WKWebView!
      
    var syptomsView = WKWebView?.self

    override func loadView() {
        symptomsView = WKWebView().self
        symptomsView.navigationDelegate = self
        view = symptomsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.nhs.uk/conditions/coronavirus-covid-19/symptoms-and-what-to-do/")!
        symptomsView.load(URLRequest(url: url))
        symptomsView.allowsBackForwardNavigationGestures = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
