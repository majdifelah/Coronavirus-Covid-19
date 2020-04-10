//
//  CountryStatsHistory.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 07/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import Foundation

struct CountryStatsHistory: Codable {
    var country: String
    var statByCountry: [StatByCountry]
    
    enum CodingKeys: String, CodingKey {
        case statByCountry = "stat_by_country"
        case country
    }
}
    
struct StatByCountry: Codable {
    var id: String
    var countryName: String
    var totalCases: String?
    var newCases: String?
    var activeCases: String?
    var totalDeaths: String?
    var newDeaths: String?
    var totalRecovered: String?
    var seriousCritical: String?
    var totalCasesPerOneMillion: String?
    var recordDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case countryName = "country_name"
        case totalCases = "total_cases"
        case newCases = "new_cases"
        case activeCases = "active_cases"
        case totalDeaths = "total_deaths"
        case newDeaths = "new_deaths"
        case totalRecovered = "total_recovered"
        case seriousCritical = "serious_critical"
        case totalCasesPerOneMillion = "total_cases_per1m"
        case recordDate = "record_date"
    }

}

