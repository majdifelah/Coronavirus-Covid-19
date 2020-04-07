//
//  AffectedCountries.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 07/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import Foundation

struct AffectedCountries: Codable {
    var affectedCountries: [Country]
    var statisticTakenAt: String

    
    enum CodingKeys: String, CodingKey {
        case affectedCountries = "affected_countries"
        case statisticTakenAt = "statistic_taken_at"
     
    }
}
struct Country: Codable {
    var country: String
}
