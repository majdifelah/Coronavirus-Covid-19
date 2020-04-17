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
    @IBOutlet weak var searchLocationTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var maleGenderButton: UIButton!
    @IBOutlet weak var femaleGenderButton: UIButton!
    @IBOutlet weak var othersGenderButton: UIButton!
    @IBOutlet weak var yesTwoWeeksHistoryButton: UIButton!
    @IBOutlet weak var noTwoWeeksHistoryButton: UIButton!
    @IBOutlet weak var maybeTwoWeeksHistoryButton: UIButton!
    
    var selfButtonChecked = false
    var familyButtonChecked = false
    var familySeniorChecked = false
    var emergencyCallChecked = false
    var maleButtonChecked = false
    var femaleButtonChecked = false
    var othersButtonChecked = false
    var yesTwoWeeksHistoryChecked = false
    var noTwoWeeksHistoryChecked = false
    var maybeTwoWeeksHistoryChecked = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO:
    }
    
    func checkButtonState(button: UIButton, state: Bool, imageChecked: String, imageUnchecked: String) {
          if !state {
              button.setImage(UIImage(named:imageChecked), for: .normal)
          } else {
              button.setImage(UIImage(named:imageUnchecked), for: .normal)
          }
      }
}

//MARK: patient test requested for
extension PatientInformationFileViewController {

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

//MARK: patient Location
extension PatientInformationFileViewController {
    @IBAction func searchLocationPlusButton(_ sender: Any) {
        
    }
}

//MARK: patient age
extension PatientInformationFileViewController {
    @IBAction func agePlusButton(_ sender: Any) {
       }
}

//MARK: patient Gender
extension PatientInformationFileViewController {
    @IBAction func maleGenderButtonAction(_ sender: Any) {
        checkButtonState(button: self.maleGenderButton, state: maleButtonChecked, imageChecked: "maleChecked", imageUnchecked: "Male")
        maleButtonChecked = !maleButtonChecked
      }
      
      @IBAction func femaleGenderButtonAction(_ sender: Any) {
        checkButtonState(button: self.femaleGenderButton, state: femaleButtonChecked, imageChecked: "femaleChecked", imageUnchecked: "Female")
        femaleButtonChecked = !femaleButtonChecked
      }
    
      @IBAction func othersGenderButtonAction(_ sender: Any) {
        checkButtonState(button: self.othersGenderButton, state: othersButtonChecked, imageChecked: "othersChecked", imageUnchecked: "others")
               othersButtonChecked = !othersButtonChecked
      }
}

//MARK: patient threatening symptoms
extension PatientInformationFileViewController {
    
}

//MARK: patient 2 weeks history
extension PatientInformationFileViewController {
    @IBAction func yesTwoWeeksHistoryButtonAction(_ sender: Any) {
        checkButtonState(button: self.yesTwoWeeksHistoryButton, state: yesTwoWeeksHistoryChecked, imageChecked: "yesChecked", imageUnchecked: "Yes")
               yesTwoWeeksHistoryChecked = !yesTwoWeeksHistoryChecked
    }
    @IBAction func noTwoWeeksHistoryButtonAction(_ sender: Any) {
        checkButtonState(button: self.noTwoWeeksHistoryButton, state: noTwoWeeksHistoryChecked, imageChecked: "noChecked", imageUnchecked: "No")
               noTwoWeeksHistoryChecked = !noTwoWeeksHistoryChecked
    }
    @IBAction func maybeTwoWeeksHistoryButtonAction(_ sender: Any) {
        checkButtonState(button: self.maybeTwoWeeksHistoryButton, state: maybeTwoWeeksHistoryChecked, imageChecked: "maybeChecked", imageUnchecked: "Maybe")
               maybeTwoWeeksHistoryChecked = !maybeTwoWeeksHistoryChecked
    }
}

//MARK: patient  symptoms
extension PatientInformationFileViewController {
    
}

extension PatientInformationFileViewController {
    
    
}
