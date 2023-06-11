//
//  CategoriesModel.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 17.05.2023.
//

import SwiftUI

// Product Model

struct Product: Identifiable, Hashable {
    var id = UUID().uuidString
    var type: ProductType
    var title: String
    var brand: String
    var description: String = ""
    var usageLevel : String
    var productImage: String = ""
    var quantity: Int = 1
    var profileImage: String = ""
    var nameSurname: String = ""
}

// Product Types
enum ProductType: String, CaseIterable { // ProductType
    case Giyim = "Giyim"
    case Müzik = "Müzik"
    case Hobi = "Hobi"
    case Spor = "Spor"
    case Diğer = "Diğer"
}
