//
//  AllCasesByCountry.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 07/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import Foundation

struct AllCasesByCountry: Codable {
    var statsTakenAt: String
    var countriesStat: [CountriesStat]
    
    enum CodingKeys: String, CodingKey {
        case statsTakenAt = "statistic_taken_at"
        case countriesStat = "countries_stat"
    }
}
    
struct CountriesStat: Codable {
    var countryName: String
    var cases: String?
    var deaths: String?
    var totalRecovered: String?
    var newDeaths: String?
    var newCases: String?
    var seriousCritical: String?
    var activeCases: String?
    var totalCasesPerOneMillionPopulation: String?
    
    enum CodingKeys: String, CodingKey {
        case countryName = "country_name"
        case totalRecovered = "total_recovered"
        case newDeaths = "new_deaths"
        case newCases = "new_cases"
        case seriousCritical = "serious_critical"
        case activeCases = "active_cases"
        case totalCasesPerOneMillionPopulation = "total_cases_per_1m_population"
        case cases, deaths
    }
}
