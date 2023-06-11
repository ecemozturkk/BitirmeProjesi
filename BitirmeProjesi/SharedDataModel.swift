//
//  SharedDataModel.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 29.05.2023.
//

import SwiftUI

class SharedDataModel : ObservableObject {
    // Detail Product data
    @Published var detailProduct: Product?
    @Published var showDetailProduct: Bool = false
    
    // Matched Geometry Effect from Search page
    @Published var fromSearchPage: Bool = false
    
    // Liked Products
    @Published var likedProducts: [Product] = []
    
    // "Takasla" request products
    @Published var takasProducts: [Product] = []
    
}

