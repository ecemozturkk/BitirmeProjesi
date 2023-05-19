//
//  StaticJSONMapper.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 19.05.2023.
//

import Foundation

struct StaticJSONMapper {
    static func decode<T: Decodable> (file: String, type: T.Type) throws -> T {
        guard let path = Bundle.main.path(forResource: file, ofType: "json"),
        let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContents
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

extension StaticJSONMapper {
    enum MappingError: Error {
        case failedToGetContents
    }
                            
}
