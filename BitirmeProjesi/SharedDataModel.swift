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
}

