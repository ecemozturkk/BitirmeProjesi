//
//  CategoriesModel.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 17.05.2023.
//

import Foundation

struct CategoriesModel: Codable {
    let success: Bool?
    let results: [CategoryResult]?
}

struct CategoryResult: Codable, Identifiable {
    let id, name, createdAt, updatedAt: String?
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name, createdAt, updatedAt
        }

}
