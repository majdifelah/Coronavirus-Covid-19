//
//  NetworkAdaptator.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 07/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import Foundation
import Moya
import Alamofire

class NetworkAdapter{
    let provider = MoyaProvider<CoronaVirus>()
    
    //MARK: get World Stat
    func getWorldStat (completion: @escaping (_ response: WorldStats?, _ error: String?) -> Void){
        self.provider.request(.getWorldStat) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                let data = response.data
                do {
                    let result = try decoder.decode(WorldStats.self, from: data)
                    
                    completion(result,nil)
                } catch {
                    completion(nil, "Error occured while getting wallet")
                }
            case .failure(let error):
                completion(nil, "\(String(describing: error.errorDescription!))")
            }
        }
    }
    
    //MARK: get Latest Stat By Country
    func getLatestStatByCountry (country: String, completion: @escaping (_ response: CountryLiveStats?, _ error: String?) -> Void){
        self.provider.request(.latestStatByCountry(country: country)) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                let data = response.data
                do {
                    let result = try decoder.decode(CountryLiveStats.self, from: data)
                    
                    completion(result,nil)
                } catch {
                    completion(nil, "Error occured while getting wallet")
                }
            case .failure(let error):
                completion(nil, "\(String(describing: error.errorDescription!))")
            }
        }
    }
    
    //MARK: get Affected Countries List
    func getAffectedCountriesList (completion: @escaping (_ response: AffectedCountries?, _ error: String?) -> Void){
        self.provider.request(.affectedCoutries) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                let data = response.data
                do {
                    let result = try decoder.decode(AffectedCountries.self, from: data)
                    
                    completion(result,nil)
                } catch {
                    completion(nil, "Error occured while getting wallet")
                }
            case .failure(let error):
                completion(nil, "\(String(describing: error.errorDescription!))")
            }
        }
    }
    
    //MARK: get Random Mask Usage Instructions
    func getRandomMaskUsageInstructions (completion: @escaping (_ response: WorldStats?, _ error: String?) -> Void){
        self.provider.request(.randomMaskUsageInstructions) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                let data = response.data
                do {
                    let result = try decoder.decode(WorldStats.self, from: data)
                    
                    completion(result,nil)
                } catch {
                    completion(nil, "Error occured while getting wallet")
                }
            case .failure(let error):
                completion(nil, "\(String(describing: error.errorDescription!))")
            }
        }
    }
    
    //MARK:get history Cases By Particular
    func getHistoryCasesByParticularCountry (country: String, completion: @escaping (_ response: CountryStatsHistory?, _ error: String?) -> Void){
        self.provider.request(.historyCasesByParticularCountry(country: country)) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                let data = response.data
                do {
                    let result = try decoder.decode(CountryStatsHistory.self, from: data)
                    completion(result,nil)
                } catch {
                    completion(nil, "Error occured while getting wallet")
                }
            case .failure(let error):
                completion(nil, "\(String(describing: error.errorDescription!))")
            }
        }
    }
    
    //MARK: get Cases By All Countries
    func getCasesByAllCountries (completion: @escaping (_ response: AllCasesByCountry?, _ error: String?) -> Void){
        self.provider.request(.casesByCountry) { result in
            switch result {
            case .success(let response):
                let decoder = JSONDecoder()
                let data = response.data
                do {
                    let result = try decoder.decode(AllCasesByCountry.self, from: data)
                    completion(result,nil)
                } catch {
                    completion(nil, "Error occured while getting wallet")
                }
            case .failure(let error):
                completion(nil, "\(String(describing: error.errorDescription!))")
            }
        }
    }
    
    //MARK:get history_by_particular_country_by_date
    //TODO:
}

