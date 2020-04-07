//
//  HomeViewModel.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 07/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import Foundation

struct HomeViewModel {
    private let worldStats: WorldStats
}

extension HomeViewModel {
    init(_ worldStats: WorldStats) {
        self.worldStats = worldStats
    }
}

extension HomeViewModel {
    
    var totalCases: String {
        return "\(self.worldStats.totalCases)"
    }
    
    var totalRecovered: String {
        return "\(self.worldStats.totalRecovered)"
    }
    
    var totalDeaths: String {
        return "\(self.worldStats.totalRecovered)"
    }
    
    var newCases: String {
        return "\(self.worldStats.newCases)"
    }
    
    var newDeaths: String {
        return "\(self.worldStats.newDeaths)"
    }
}

