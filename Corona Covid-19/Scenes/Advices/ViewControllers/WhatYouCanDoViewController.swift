//
//  WhatYouCanDoViewController.swift
//  Corona Covid-19
//
//  Created by Majdi EL Felah on 22/05/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import UIKit

class WhatYouCanDoViewController: UIViewController {

    @IBOutlet weak var washingHandsView: UIView!
    @IBOutlet weak var socialDistancingView: UIView!
    @IBOutlet weak var isolateYourselfView: UIView!
    @IBOutlet weak var sympthomsView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.washingHandsView.shadowForView()
        self.socialDistancingView.shadowForView()
        self.isolateYourselfView.shadowForView()
        self.sympthomsView.shadowForView()

    }
}
