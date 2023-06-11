//
//  HomeViewModel.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 23.05.2023.
//

import SwiftUI

//Using Combine to monitor search field and if user leaves for .5 secs then starts searching to avoid memory issues
import Combine

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .Giyim
    
    // Sample Products..
    @Published var products: [Product] = [
        Product(type: .Müzik, title:"Gitar", brand:"Yamaha",description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "guitar", profileImage: "profileImage", nameSurname: "Ali Yılmaz"),
        Product(type: .Spor, title:"Raket", brand:"Marka", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "raket", profileImage: "profileImage", nameSurname: "Ali Yılmaz"),
        Product(type: .Müzik, title:"Plak", brand:"Marka", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "plak", profileImage: "profileImage", nameSurname: "Ali Yılmaz"),
        Product(type: .Giyim, title:"Pantolon", brand:"Marka", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "pantolon", profileImage: "profileImage", nameSurname: "Ali Yılmaz"),
        Product(type: .Giyim, title:"Tişört", brand:"Marka", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "tshirt", profileImage: "profileImage", nameSurname: "Ali Yılmaz"),
        Product(type: .Giyim, title:"Ayakkabı", brand:"Marka", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "sneakers", profileImage: "profileImage", nameSurname: "Ali Yılmaz"),
        Product(type: .Spor, title:"Raket", brand:"Marka", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "raket2", profileImage: "profileImage", nameSurname: "Ali Yılmaz"),
        Product(type: .Müzik, title:"Gitar", brand:"Yamaha", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "guitar", profileImage: "profileImage", nameSurname: "Ali Yılmaz"),
        Product(type: .Müzik, title:"Gitar", brand:"Yamaha", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "guitar", profileImage: "profileImage", nameSurname: "Ali Yılmaz")
    ]
    
    // User Products
    @Published var userProducts: [Product] = [
        Product(type: .Müzik, title:"UserGitar", brand:"Yamaha",description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "guitar", profileImage: "profileImage"),
        Product(type: .Spor, title:"Raket", brand:"Marka", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "raket", profileImage: "profileImage"),
        Product(type: .Müzik, title:"Plak", brand:"Marka", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "plak", profileImage: "profileImage"),
        Product(type: .Giyim, title:"Pantolon", brand:"Marka", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "pantolon", profileImage: "profileImage"),
        Product(type: .Giyim, title:"Tişört", brand:"Marka", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "tshirt", profileImage: "profileImage"),
        Product(type: .Giyim, title:"Ayakkabı", brand:"Marka", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "sneakers", profileImage: "profileImage"),
        Product(type: .Spor, title:"Raket", brand:"Marka", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "raket2", profileImage: "profileImage"),
        Product(type: .Müzik, title:"Gitar", brand:"Yamaha", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "guitar", profileImage: "profileImage"),
        Product(type: .Müzik, title:"Gitar", brand:"Yamaha", description: "Ürünü iki yıl önce aldım, çok kullanmadım bir sorunu yoktur." ,usageLevel:"Az kullanıldı", productImage: "guitar", profileImage: "profileImage")

    ]
    
    
    
    // Filtered Products
    @Published var filteredProducts: [Product] = []
    
    // More products on the type
    @Published var showMoreProductsOnType: Bool = false
    
    // Search Data
    @Published var searchText : String = ""
    @Published var searchActivated : Bool = false
    @Published var searchedProducts : [Product]?
    
    var searchCancellable: AnyCancellable?
    
    init() {
       filterProductByType()
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str != "" {
                    self.filterProductBySearch()
                } else {
                    self.searchedProducts = nil
                }
            })
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
    
    func filterProductBySearch() {
        DispatchQueue.global(qos: .userInteractive).async {
            
            let results = self.products
            // Since it will require more memory so we're using lazy to perform more
                .lazy
                .filter { product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            
            DispatchQueue.main.async {
                self.searchedProducts = results.compactMap({ product in
                    return product
                })
            }
        }
    }
}
