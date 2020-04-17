//
//  ViewController.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 30/03/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//


import Foundation

//struct SearchListViewModel {
//    let countryCovidStats: [LatestStatByCountry]
//}
//
//extension SearchListViewModel {
//    
//    var numberOfSections: Int {
//        return 1
//    }
//    
//    func numberOfRowsInSection(_ section: Int) -> Int {
//        return self.countryCovidStats.count
//    }
//    
//    func searchStatAtIndex(_ index: Int) -> SearchViewModel {
//        let coutryCovidStat = self.countryCovidStats[index]
//        return SearchViewModel(coutryCovidStat)
//    }
//    
//}

struct SearchViewModel {
    private let countryCovidStat: LatestStatByCountry
}

extension SearchViewModel {
    init(_ countryCovidStat: LatestStatByCountry) {
        self.countryCovidStat = countryCovidStat
    }
}

extension SearchViewModel {
    
    var totalCases: String {
        return trimmeResult(string: self.countryCovidStat.totalCases)
    }
    
    var totalDeaths: String {
        return trimmeResult(string: self.countryCovidStat.totalDeaths)
    }
    
    var totalRecovered: String {
        return trimmeResult(string: self.countryCovidStat.totalRecovered)
    }
    
    var newCases: String {
            return trimmeResult(string: self.countryCovidStat.newCases)
    }
    
    var newDeaths: String {
        return trimmeResult(string: self.countryCovidStat.newDeaths)
    }
    var activeCases: String {
        return trimmeResult(string: self.countryCovidStat.activeCases)
    }
    
    var seriousCritical: String {
        return trimmeResult(string: self.countryCovidStat.seriousCritical ?? "0")
    }
}

extension SearchViewModel {
    func trimmeResult(string: String) -> String {
        
        if string.count == 0 {return "0"} else {
            return string
        }
    }
}
