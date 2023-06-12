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
    var description: String = ""
    var usageLevel : String
    var productImage: String = ""
    var quantity: Int = 1
    var profileImage: String = ""
    var nameSurname: String = ""
}

// Product Types
enum ProductType: String, CaseIterable { // ProductType
    case Elektronik = "Elektronik"
    case Giyim = "Giyim"
    case Spor = "Spor"
    case Hobi = "Hobi"
    case Bahçe = "Bahçe"
    case Diğer = "Diğer"
}


