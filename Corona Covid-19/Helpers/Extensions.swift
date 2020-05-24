//
//  Extensions.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 07/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

//extension UIPageControl {
//    
//    func configurePageControl(numberOfPages: Int, view: UIViewController) {
//        
//        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY -  50, width: UIScreen.main.bounds.width, height: 50))
//        pageControl.numberOfPages = numberOfPages
//        pageControl.currentPage = 0
//        pageControl.tintColor = .black
//        pageControl.pageIndicatorTintColor = .black
//        self.view.addSubview(pageControl)
//    }
//    
//}

extension UIView {
    
    func shadowForView() {
        
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius  = 15
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        
    }
}
