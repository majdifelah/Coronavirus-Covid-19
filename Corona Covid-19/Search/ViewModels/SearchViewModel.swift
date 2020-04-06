//
//  ViewController.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 30/03/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//


import Foundation

struct SearchListViewModel {
    let countryCovidStats: [CovidStats]
}

extension SearchListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.countryCovidStats.count
    }
    
    func searchStatAtIndex(_ index: Int) -> SearchViewModel {
        let coutryCovidStat = self.countryCovidStats[index]
        return SearchViewModel(coutryCovidStat)
    }
    
}


struct SearchViewModel {
    private let countryCovidStat: CovidStats
}

extension SearchViewModel {
    init(_ countryCovidStat: CovidStats) {
        self.countryCovidStat = countryCovidStat
    }
}

extension SearchViewModel {
    
    var deathsCases: String {
        return "\(self.countryCovidStat.deaths)"
    }
    
    var recoveredCases: String {
        return "\(self.countryCovidStat.recovered)"
    }
    
    var confirmedCases: String {
        return "\(self.countryCovidStat.confirmed)"
    }
}

