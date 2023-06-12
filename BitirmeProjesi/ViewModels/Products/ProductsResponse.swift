//
//  ProductsResponse.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 19.05.2023.
//

import Foundation

struct ProductsResponse : Codable {
    let success: Bool
    let data: [ProductData]
}
