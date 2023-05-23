//
//  HomeViewModel.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 23.05.2023.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .Giyim
    
    // Sample Products..
    @Published var products: [Product] = [
        Product(type: .Müzik, title:"Gitar", subtitle:"Yamaha", usageLevel:"Az kullanıldı", productImage: "guitar"),
        Product(type: .Spor, title:"Raket", subtitle:"Marka", usageLevel:"Az kullanıldı", productImage: "raket"),
        Product(type: .Müzik, title:"Plak", subtitle:"Marka", usageLevel:"Az kullanıldı", productImage: "plak"),
        Product(type: .Giyim, title:"Pantolon", subtitle:"Marka", usageLevel:"Az kullanıldı", productImage: "pantolon"),
        Product(type: .Giyim, title:"Tişört", subtitle:"Marka", usageLevel:"Az kullanıldı", productImage: "tshirt"),
        Product(type: .Giyim, title:"Ayakkabı", subtitle:"Marka", usageLevel:"Az kullanıldı", productImage: "sneakers"),
        Product(type: .Spor, title:"Raket", subtitle:"Marka", usageLevel:"Az kullanıldı", productImage: "raket2"),
        Product(type: .Müzik, title:"Gitar", subtitle:"Yamaha", usageLevel:"Az kullanıldı", productImage: "guitar"),
        Product(type: .Müzik, title:"Gitar", subtitle:"Yamaha", usageLevel:"Az kullanıldı", productImage: "guitar")

    ]
    
    // Filtered Products
    @Published var filteredProducts: [Product] = []
    
    // More products on the type
    @Published var showMoreProductsOnType: Bool = false
    
    init() {
       filterProductByType()
    }
    
    func filterProductByType() {
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
            // Since it will require more memory so we're using lazy to perform more
                .lazy
                .filter { product in
                    return product.type == self.productType
                }
            // Limiting result..
                .prefix(4)
            
            DispatchQueue.main.async {
                self.filteredProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
