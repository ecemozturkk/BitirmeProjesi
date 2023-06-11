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
