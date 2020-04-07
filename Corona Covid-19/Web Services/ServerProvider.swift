//
//  ServerProvider.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 07/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import Foundation
import Moya


enum CoronaVirus{
    case getWorldStat
    case latestStatByCountry(country: String)
    case affectedCoutries
    case randomMaskUsageInstructions
    case historyCasesByParticularCountry(country: String)
    case historyByCountryandDate(country: String, date: String)
    case casesByCountry(country: String)
}

extension CoronaVirus: TargetType, AccessTokenAuthorizable {
    /// The target's base `URL`.
    var baseURL: URL {
        //    if let baseUrl = Configuration.shared.currentBaseURL {
        //        return URL(string: baseUrl)!
        //    }
        return URL(string: "https://coronavirus-monitor.p.rapidapi.com")!
    }
    var path: String {
        switch self{
        case .getWorldStat:
            return ""
        case .latestStatByCountry:
            return ""
        case .affectedCoutries:
            return ""
        case .randomMaskUsageInstructions:
            return ""
        case .historyCasesByParticularCountry:
            return ""
        case .historyByCountryandDate:
            return ""
        case .casesByCountry:
            return ""

        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWorldStat, .latestStatByCountry, .affectedCoutries, .randomMaskUsageInstructions, .historyCasesByParticularCountry, .historyByCountryandDate, .casesByCountry:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        case .getWorldStat, .latestStatByCountry, .affectedCoutries, .randomMaskUsageInstructions, .historyCasesByParticularCountry, .historyByCountryandDate, .casesByCountry:
    }
    
    var headers: [String : String]? {
        return [
            "x-rapidapi-host": "coronavirus-monitor.p.rapidapi.com",
            "x-rapidapi-key": "d1a950c768msh44aa32c43ffd5edp1294fajsn08ab66121b90"
        ]
    }
    
    var authorizationType: AuthorizationType {
        return .none
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
