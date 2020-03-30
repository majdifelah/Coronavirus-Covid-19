//
//  ViewController.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 30/03/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//


import Foundation

class SearchViewModel {
    
    let apiManager = APIManager()
    var covidByCountry: [CovidStats] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let country = "united kingdom"
//        searchForCovidInCountry(country.capitalized)
//        
//    }
    
    func searchForCovidInCountry(_ country: String) {
        
        apiManager.searchFor(country) { [unowned self] outcome in
            
            switch outcome {
            case .failure(let errorString):
                print(errorString)
            case .success(let data):
                do {
                    let result = try JSONParser.parse(data, type: CodivLastResultRoot.self)
                    self.covidByCountry = result.data.covid19Stats
                    print("the result : \(self.covidByCountry)")
                } catch {
                    print("JSON Error: \(error)")
                }
            }
        }
    }

}
