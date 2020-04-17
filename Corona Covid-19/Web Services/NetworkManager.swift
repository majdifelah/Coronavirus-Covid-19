//
//  NetworkManager.swift
//  Corona Covid-19
//
//  Created by Majdi Felah on 11/04/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<CoronaVirus> { get }
    
    func getPosts(completion: @escaping ([CoronaVirus]?, Error?) -> ())
    func getPostWith(id: Int, completion: @escaping (CoronaVirus?, Error?) -> ())
    func createPosth(post: String, completion: @escaping (CoronaVirus?, Error?) -> ())
}

class NetworkManager {

var provider = MoyaProvider<CoronaVirus>(plugins: [NetworkLoggerPlugin(verbose: true)])

}

