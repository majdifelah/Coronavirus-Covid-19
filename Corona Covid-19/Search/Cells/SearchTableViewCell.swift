//
//  SearchTableViewCell.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 30/03/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var confirmedCasesLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var recoveredCasesLabel: UILabel!
    
    func configureCell(countryCovidStat: SearchViewModel) {
        //countryImage.image = UIImage(
        confirmedCasesLabel.text = "Confirmed: \(countryCovidStat.confirmedCases)"
        deathsLabel.text = "Deaths: \(countryCovidStat.deathsCases)"
        recoveredCasesLabel.text = "Recovered: \(countryCovidStat.recoveredCases)"
    }
}
