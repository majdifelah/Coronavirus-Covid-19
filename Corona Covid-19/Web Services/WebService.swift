//
//  WebService.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 06/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

//import Foundation
//
//class WebsService {
//    
//    let apiManager = APIManager()
//    var covidByCountry: [CovidStats] = []
//    
//    func searchForCovidInCountry(_ country: String) {
//        
//        apiManager.searchFor(country) { [unowned self] outcome in
//            
//            switch outcome {
//            case .failure(let errorString):
//                print(errorString)
//            case .success(let data):
//                do {
//                    let result = try JSONParser.parse(data, type: CodivLastResultRoot.self)
//                    self.covidByCountry = result.data.covid19Stats
//                    print("the result : \(self.covidByCountry)")
//                } catch {
//                    print("JSON Error: \(error)")
//                }
//            }
//        }
//    }
//    
//}
