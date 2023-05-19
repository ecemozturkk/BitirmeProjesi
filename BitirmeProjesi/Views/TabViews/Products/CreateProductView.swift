//
//  CreateProductView.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 19.05.2023.
//

import SwiftUI

struct CreateProductView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
       NavigationView {
            Form {
                productName
                productDescription
                productImage
                Text(" incomingOffers: [] ?????????")
                /// KATEGORİ?????????
                /// TAGS
                /// ACCEPTED CATEGORİES
                productUsageLevel
                
                Section {
                    Button ("Ürün Oluştur") {
                        // Handle action
                    }
                }
                .navigationTitle("Ürünü Oluştur")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        vazgecButton
                    }
                }
            }
        }
    }
}

/*
 {
   "name": "Elektro Gitarrrrr",
   "description": "Arkadasimin gitarisi o yuzden satiyorum. Ne yaniii",
   "image": "-",
   "categoryId": ["6424a618eb9f4d7f5fadc466", "6424a620eb9f4d7f5fadc468"],
   "usageLevel": 2,
   "tags": ["music", "akustik", "anfi"],
   "incomingOffers": [],
   "acceptedCategories": ["6424a620eb9f4d7f5fadc468"]
 }
 */


struct CreateProductView_Previews: PreviewProvider {
    static var previews: some View {
        CreateProductView()
    }
}

private extension CreateProductView {
    
    var vazgecButton: some View {
        Button ("Vazgeç") {
            dismiss()
        }
    }
    var productName : some View {
        TextField("Ürün Adı:", text: .constant(""))
    }
    var productDescription : some View {
        TextField("Ürün Açıklaması: ", text: .constant(""))
    }
    var productImage : some View {
        TextField("Ürün Görseli: ", text: .constant(""))
    }
    var productUsageLevel : some View {
        TextField("Kullanım Durumu", text: .constant(""))
    }
    

}
