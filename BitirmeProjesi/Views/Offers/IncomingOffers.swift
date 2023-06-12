//
//  Deneme.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 11.06.2023.
//

import SwiftUI



struct IncomingOffers: View {
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    // Delete Option
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Text("Gelen Takas İsteklerim")
                            .font(.custom(customFont, size: 28).bold())
                        Spacer()
                        Button {
                            withAnimation {
                                showDeleteOption.toggle()
                            }
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(.red)
                        }
                        .opacity(sharedData.takasProducts.isEmpty ? 0 : 1)
                    }
                    
                    if sharedData.takasProducts.isEmpty {
                        Group {
                            Image("EmptyCart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .padding(.top, 35)
                            Text("Henüz bir takas isteğinde bulunmadın!")
                                .font(.custom(customFont, size: 25))
                                .fontWeight(.semibold)
                            Text("Favori ürünleri kaydetmek için her ürün sayfasındaki takasla butonuna bas :)")
                                .font(.custom(customFont, size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }
                    } else {
                        // Displaying Products
                        VStack(spacing: 15) {
                            ForEach($sharedData.takasProducts){ $product in
                                HStack(spacing: 0) {
                                    
                                    if showDeleteOption {
                                        Button {
                                            deleteProduct(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.trailing)
                                        
                                    }
                                    
                                    
                                    CardView2(product: $product)
                                }
                            }
                        }
                        .padding(.top, 25)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Theme.darkWhite.ignoresSafeArea())
        }
    }
    func deleteProduct(product: Product) {
        if let index = sharedData.takasProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }) {
            let _ = withAnimation {
                // removing..
                sharedData.takasProducts.remove(at: index)
            }
        }
    }
}

struct IncomingOffers_Previews: PreviewProvider {
    static var previews: some View {
        IncomingOffers()
    }
    
}

struct CardView2 : View {
    
    // Making Product as Binding so as to update in Real time
    @Binding var product : Product
    
    var body: some View {
        HStack(spacing: 15) {
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.custom(customFont, size: 18).bold())
                    .lineLimit(1)
                /*
                Text(product.brand)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                 */
                
                Text("Kategori: \(product.type.rawValue)")
                    .font(.custom(customFont, size: 13))
                    .foregroundColor(.gray)
                
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color.white.cornerRadius(10)
        )
    }
}
