//
//  ScrollViewExampleViewController.swift
//  Corona Covid-19
//
//  Created by Majdi EL Felah on 21/05/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import Foundation
import FittedSheets

class ScrollViewExampleViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sheetViewController?.handleScrollView(self.scrollView)
    }
    
    static func instantiate() -> ScrollViewExampleViewController {
        return UIStoryboard(name: "main", bundle: nil).instantiateViewController(withIdentifier: "scrollView") as! ScrollViewExampleViewController
    }
}
