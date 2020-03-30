//
//  CovidModel.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 30/03/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import Foundation

struct CodivLastResultRoot: Codable {
    var data: DataCovid
}

struct DataCovid: Codable {
    var lastChecked: String
    var covid19Stats: [CovidStats]
}
struct CovidStats: Codable {

    var city: String
    var province: String
    var country: String
    var lastUpdate: String
    var keyId: String
    var confirmed: Int
    var deaths: Int
    var recovered: Int
}
