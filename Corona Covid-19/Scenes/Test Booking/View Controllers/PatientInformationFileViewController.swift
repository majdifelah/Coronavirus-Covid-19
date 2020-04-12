//
//  PatientInformationFileViewController.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 11/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import UIKit

class PatientInformationFileViewController: UIViewController {
    
    @IBOutlet weak var selfButtonTestRequestFor: UIButton!
    @IBOutlet weak var familyTestRequestForButton: UIButton!
    @IBOutlet weak var familySeniorTestRequestForButton: UIButton!
    @IBOutlet weak var emergencyTestRequestForButton: UIButton!
    var selfButtonChecked = false
    var familyButtonChecked = false
    var familySeniorChecked = false
    var emergencyCallChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO:
    }
    
    @IBAction func selfButtonChecked(_ sender: Any) {
        checkButtonState(button: self.selfButtonTestRequestFor, state: selfButtonChecked, imageChecked: "selfChecked", imageUnchecked: "self")
        selfButtonChecked = !selfButtonChecked
    }
    @IBAction func familyButtonPressed() {
        checkButtonState(button: self.familyTestRequestForButton, state: familyButtonChecked, imageChecked: "familyChecked", imageUnchecked: "family")
        familyButtonChecked = !familyButtonChecked
    }
    @IBAction func familySeniorButtonPressed() {
        checkButtonState(button: self.familySeniorTestRequestForButton, state: familySeniorChecked, imageChecked: "familySeniorChecked", imageUnchecked: "familySenior")
        familySeniorChecked = !familySeniorChecked
    }
    @IBAction func emergencyButtonPressed() {
        checkButtonState(button: self.emergencyTestRequestForButton, state: emergencyCallChecked, imageChecked: "emergencyCallChecked", imageUnchecked: "emergencyCall")
        emergencyCallChecked = !emergencyCallChecked
    }
    
}

//MARK: patient test requested for
extension PatientInformationFileViewController {
    func checkButtonState(button: UIButton, state: Bool, imageChecked: String, imageUnchecked: String) {
        if !state {
            button.setImage(UIImage(named:imageChecked), for: .normal)
        } else {
            button.setImage(UIImage(named:imageUnchecked), for: .normal)
        }
    }
}

//MARK: patient Location
extension PatientInformationFileViewController {
    
}

//MARK: patient age
extension PatientInformationFileViewController {
    
}

//MARK: patient Gender
extension PatientInformationFileViewController {
    
}

//MARK: patient threatening symptoms
extension PatientInformationFileViewController {
    
}

//MARK: patient 2 weeks history
extension PatientInformationFileViewController {
    
}

//MARK: patient  symptoms
extension PatientInformationFileViewController {
    
}

extension PatientInformationFileViewController {
    
    
}
