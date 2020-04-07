//
//  ServerProvider.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 07/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import Foundation
import Moya


enum CoronaVirus {
    case getWorldStat
    case latestStatByCountry(country: String)
    case affectedCoutries
    case randomMaskUsageInstructions
    case historyCasesByParticularCountry(country: String)
    case historyByCountryandDate(country: String, date: String)
    case casesByCountry
}

extension CoronaVirus: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        return URL(string: "https://coronavirus-monitor.p.rapidapi.com/coronavirus")!
    }
    var path: String {
        
        switch self {
        case .getWorldStat:
            return "/worldstat.php"
        case .latestStatByCountry:
            return "/latest_stat_by_country.php"
        case .affectedCoutries:
            return "/affected.php"
        case .randomMaskUsageInstructions:
            return "/random_masks_usage_instructions.php"
        case .historyCasesByParticularCountry:
            return "/cases_by_particular_country.php"
        case .historyByCountryandDate:
            return "/history_by_particular_country_by_date.php"
        case .casesByCountry:
            return "/cases_by_country.php"

        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWorldStat, .latestStatByCountry, .affectedCoutries, .randomMaskUsageInstructions, .historyCasesByParticularCountry, .historyByCountryandDate, .casesByCountry:
            return .get
        }
    }
    
    var parameters: [String:Any]? {
        switch self {
        case .historyCasesByParticularCountry(let country):
          return ["country": country]
        case .historyByCountryandDate(let country, let date):
            return ["country": country, "date": date]
        case .latestStatByCountry(let country):
            return ["country":country]
        case .getWorldStat, .affectedCoutries ,.randomMaskUsageInstructions,.casesByCountry:
            return nil
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getWorldStat, .affectedCoutries, .randomMaskUsageInstructions,.casesByCountry:
        return .requestPlain
        
        default:
        if let params = self.parameters {
            var data = [MultipartFormData]()
            for (key, value) in params {
                if let str = value as? String {
                    let v = str.data(using: .utf8)!
                    data.append(MultipartFormData(provider: .data(v), name: key))
                }
            }
            return .uploadCompositeMultipart(data, urlParameters: [:])
        } else {
            return .requestPlain
        }
        }
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
