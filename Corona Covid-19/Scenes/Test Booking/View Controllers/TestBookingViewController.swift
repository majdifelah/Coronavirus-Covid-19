//
//  TestBookingViewController.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 11/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import UIKit

class TestBookingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        
    }
    @IBAction func loginButtonAction(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "whatYouLookingFor") as! WhatYouLookingForViewController
        //self.present(next, animated: true, completion: nil)
        self.navigationController?.pushViewController(next, animated: true)
    }
}
