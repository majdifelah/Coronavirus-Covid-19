//
//  MFButton.swift
//  Corona Covid-19
//
//  Created by Majdi EL Felah on 22/05/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import Foundation
import UIKit

class MFButton: UIButton {
    
    var isOn = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton() {
        layer.borderWidth = 2.0
        layer.borderColor = Colors.twitterBlue.cgColor
        layer.cornerRadius = 15
        
        setTitleColor(Colors.twitterBlue, for: .normal)
        addTarget(self, action: #selector(MFButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed() {
        activateButton(bool: !isOn)
    }
    
    func activateButton(bool: Bool) {
        
        isOn = bool
        
        let color = bool ? Colors.twitterBlue : .clear
        let title = bool ? "Calling 111" : "Call 111"
        let titleColor = bool ? .white : Colors.twitterBlue
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = color
        
        if let url = URL(string: "tel://111"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    
}
