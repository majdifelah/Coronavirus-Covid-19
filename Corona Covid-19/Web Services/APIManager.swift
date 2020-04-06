//
//  APIManager.swift
//  LastFM
//
//  Created by Majdi Felah on 21/02/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import Foundation

enum Outcome {
    case success(Data)
    case failure(String)
}
enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

final class APIManager {
    
    private let session: URLSession
    //Dependency Injection
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
   
    let headers = [
        "x-rapidapi-host": "covid-19-coronavirus-statistics.p.rapidapi.com",
        "x-rapidapi-key": "d1a950c768msh44aa32c43ffd5edp1294fajsn08ab66121b90"
    ]
    private func createURLComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "covid-19-coronavirus-statistics.p.rapidapi.com"
        urlComponents.path = "/v1/stats"
        return urlComponents
    }

    
    private func fetch(with url: URL, completion: @escaping (Outcome) -> Void) {
        print("the url: \(url)")
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
                request.httpMethod = "GET"
                request.allHTTPHeaderFields = headers
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(error.localizedDescription))
            } else if let data = data, let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...299:
                    completion(.success(data))
                    print("was successful")
                default:
                    completion(.failure("Response not in range 200-299"))
                }
            }
        }
        dataTask.resume()
    }
    
    func searchFor(_ country: String, completion: @escaping (Outcome) -> Void) {
        var urlComponents = createURLComponents()
        urlComponents.queryItems = [
            URLQueryItem(name: "country", value: "\(country)")
        ]
        
        guard let searchURL = urlComponents.url else {
            completion(.failure("Unable to make URL"))
            return
        }
    
        
        fetch(with: searchURL, completion: completion)
    }
}
