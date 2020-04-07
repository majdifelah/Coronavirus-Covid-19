//
//  CountryStats.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 07/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import Foundation

struct CountryLiveStats: Codable {
    var country: String
    var latestStatByCountry: [LatestStatByCountry]
    
    enum CodingKeys: String, CodingKey {
        case latestStatByCountry = "latest_stat_by_country"
        case country
    }
}
    
struct LatestStatByCountry: Codable {
    var totalCases: String
    var totalDeaths: String
    var totalRecovered: String
    var newCases: String
    var newDeaths: String
    var statisticTakenAt: String
    
    enum CodingKeys: String, CodingKey {
        case totalCases = "total_cases"
        case totalDeaths = "total_deaths"
        case totalRecovered = "total_recovered"
        case newCases = "new_cases"
        case newDeaths = "new_deaths"
        case statisticTakenAt = "statistic_taken_at"
    }
}
