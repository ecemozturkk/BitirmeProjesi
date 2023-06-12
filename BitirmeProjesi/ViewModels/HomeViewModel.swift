//
//  HomeViewModel.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 23.05.2023.
//

import SwiftUI

//Using Combine to monitor search field and if user leaves for .5 secs then starts searching to avoid memory issues
import Combine

//Elektronik
//Giyim
//Spor
//Hobi
//Bahçe
//Diğer

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .Giyim
    
    // Sample Products..
    @Published var products: [Product] = [
        Product(type: .Elektronik, title:"X-Box Oyun Konsolu",description: "Bir üst versiyonunu aldım. Bu yüzden müzik aletleri öncelikle olarak takas tekliflerine açığım.", usageLevel:"Az kullanıldı", productImage: "xbox", profileImage: "Ecem", nameSurname: "Ecem Öztürk"),
        Product(type: .Hobi, title:"Akustik Gitar",description: "Öğrenmek için almıştım ancak zaman bulamıyorum. Başka hobi ürünleri ile takaslamaya açığım.", usageLevel:"Kullanılmış Ürün", productImage: "guitar2", profileImage: "Fatih", nameSurname: "Fatih Es"),
        Product(type: .Elektronik, title:"iPhone 11",description: "Yurt dışından geldi ve kullanım fazlası bir ürün. Takas tekliflerinizi bekliyorum :)", usageLevel:"Yeni/Etiketli", productImage: "iphone", profileImage: "Fatih", nameSurname: "Fatih Es"),
        Product(type: .Elektronik, title:"iPhone 11",description: "Yurt dışından geldi ve kullanım fazlası bir ürün. Takas tekliflerinizi bekliyorum :)", usageLevel:"Yeni/Etiketli", productImage: "iphone", profileImage: "Fatih", nameSurname: "Fatih Es"),
        Product(type: .Giyim, title:"Çocuk Şortu",description: "Birkaç gün önce aldık ancak çocuğuma olmadı. İade edemiyoruz. Giyim ürünleri ile takas edilir.", usageLevel:"Yeni/Etiketli", productImage: "şort", profileImage: "Yılmaz", nameSurname: "Yılmaz Kalınlı"),
        Product(type: .Spor, title:"Ağırlık Seti",description: "Sadece birkaç ay kullanıldı. Sonrasında kullanmadı kimse, hobi ürünler öncelikle olmak kaydı ile takas tekliflerine açığım.", usageLevel:"Az Kullanılmış", productImage: "ağırlık", profileImage: "Yılmaz", nameSurname: "Yılmaz Kalınlı"),
        Product(type: .Spor, title:"Nike - Air Jordan",description: "Almanya'dan kuzenim getirdi ama kullanmıyorum. Bu yüzden takas tekliflerini bekliyorum.", usageLevel:"Yeni/Etiketli", productImage: "jordan", profileImage: "Yılmaz", nameSurname: "Yılmaz Kalınlı"),
        Product(type: .Diğer, title:"Çalışma Masası",description: "Başka bir şehre taşınacağım için takas tekliflerinizi bekliyorum. Yanımda taşımak istiyorum.", usageLevel:"Az Kullanılmış", productImage: "masa", profileImage: "Yılmaz", nameSurname: "Yılmaz Kalınlı"),
        Product(type: .Giyim, title:"Çanta",description: "Eski sevgilimin hediyesiydi. Ayrıldık, bu yüzden kullanmak istemiyorum daha fazla. Takas tekliflerine açığım.", usageLevel:"Az Kullanılmış", productImage: "canta", profileImage: "Ecem", nameSurname: "Ecem Öztürk"),
        Product(type: .Giyim, title:"Adidas - Mont",description: "Almıştım ancak hiç kullanmadım. Şimdi bedeni küçük geliyor. Hiç kullanılmamış denilebilir. Alana hayırlı olsun.", usageLevel:"Yeni/Etiketli", productImage: "mont", profileImage: "Ecem", nameSurname: "Ecem Öztürk"),
        Product(type: .Elektronik, title:"Monitör",description: "Bir üst versiyonunu alıyorum bu yüzden takas tekliflerine açığım. Samsung Lc49rg90ssrxuf 49 Inç Crg9 4 Ms 120 Hz monitör.", usageLevel:"Az Kullanılmış", productImage: "monitor", profileImage: "Ecem", nameSurname: "Ecem Öztürk"),
        Product(type: .Bahçe, title:"Bahçe Hobi Seti",description: "Eskiden bahçe işleri ile hobi olarak çok ilgilendirdim. Artık eskisi gibi ilgilenmiyorum bu yüzden takas tekliflerine açığım.", usageLevel:"Kullanılmış", productImage: "bahce", profileImage: "Ecem", nameSurname: "Ecem Öztürk"),
        Product(type: .Elektronik, title:"Air Pods 3. Nesil",description: "Hediye geldi ancak zaten halihazırda aynı ürünü kullanıyorum. Bilgisayar ekipmanları önceliğimdir.", usageLevel:"Yeni/Etiketli ", productImage: "airpods", profileImage: "Ecem", nameSurname: "Ecem Öztürk")
    ]
    
    // User Products
    @Published var userProducts: [Product] = [
        Product(type: .Elektronik, title: "X-Box Oyun Konsolu", description: "Bir üst versiyonunu aldım. Bu yüzden müzik aletleri öncelikle olarak takas tekliflerine açığım.", usageLevel: "Az Kullanılmış", productImage: "xbox", profileImage: "Ecem", nameSurname: "Ecem Öztürk"),
        Product(type: .Giyim, title: "Çanta", description: "Eski sevgilimin hediyesiydi. Ayrıldık, bu yüzden kullanmak istemiyorum daha fazla. Takas tekliflerine açığım.", usageLevel: "Az Kullanılmış", productImage: "canta", profileImage: "Ecem", nameSurname: "Ecem Öztürk"),
        Product(type: .Giyim, title: "Adidas - Mont", description: "Almıştım ancak hiç kullanmadım. Şimdi bedeni küçük geliyor. Hiç kullanılmamış denilebilir. Alana hayırlı olsun.", usageLevel: "Yeni/Etiketli", productImage: "mont", profileImage: "Ecem", nameSurname: "Ecem Öztürk"),
        Product(type: .Elektronik, title: "Monitör", description: "Bir üst versiyonunu alıyorum bu yüzden takas tekliflerine açığım. Samsung Lc49rg90ssrxuf 49 Inç Crg9 4 Ms 120 Hz monitör.", usageLevel: "Az Kullanılmış", productImage: "monitor", profileImage: "Ecem", nameSurname: "Ecem Öztürk"),
        Product(type: .Hobi, title: "Bahçe Hobi Seti", description: "Eskiden bahçe işleri ile hobi olarak çok ilgilendirdim. Artık eskisi gibi ilgilenmiyorum bu yüzden takas tekliflerine açığım.", usageLevel: "Kullanılmış", productImage: "bahce", profileImage: "Ecem", nameSurname: "Ecem Öztürk"),
        Product(type: .Elektronik, title: "Air Pods 3. Nesil", description: "Hediye geldi ancak zaten halihazırda aynı ürünü kullanıyorum. Bilgisayar ekipmanları önceliğimdir.", usageLevel: "Yeni/Etiketli", productImage: "airpods", profileImage: "Ecem", nameSurname: "Ecem Öztürk")
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
