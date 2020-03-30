//
//  Parser.swift
//  LastFM
//
//  Created by Majdi Felah on 21/02/2020.
//  Copyright © 2020 Majdi Felah. All rights reserved.
//

import Foundation

struct JSONParser {
    
    static func parse<T>(_ data: Data, type: T.Type) throws -> T where T : Decodable {
        
        return try JSONDecoder().decode(type.self, from: data)
        
    }
    
}
