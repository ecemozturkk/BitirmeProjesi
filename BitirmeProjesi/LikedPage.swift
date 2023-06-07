//
//  LikedPage.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 8.06.2023.
//

import SwiftUI

struct LikedPage: View {

    @EnvironmentObject var sharedData: SharedDataModel
    
    // Delete option
    @State var showDeleteOption: Bool = false
    
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Text("Favoriler")
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
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)

                    }
                    // checking if liked products are empty..
                    if sharedData.likedProducts.isEmpty {
                        Group {
                            Image("EmptyLiked")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .padding(.top, 35)
                            Text("Henüz bir ürün beğenmedin!")
                                .font(.custom(customFont, size: 25))
                                .fontWeight(.semibold)
                            Text("Favori ürünleri kaydetmek için her ürün sayfasındaki kalp düğmesine bas :)")
                                .font(.custom(customFont, size: 18))
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding(.top, 10)
                                .multilineTextAlignment(.center)
                        }
                    } else {
                        // Displaying liked products..
                        VStack(spacing: 15) {
                            ForEach(sharedData.likedProducts){ product in
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
                                    
                                    
                                    CardView(product: product)
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
    @ViewBuilder func CardView(product: Product) -> some View {
        HStack(spacing: 15) {
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.custom(customFont, size: 18).bold())
                    .lineLimit(1)
                
                Text(product.subtitle)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                
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
    
    func deleteProduct(product: Product) {
        if let index = sharedData.likedProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }) {
            let _ = withAnimation {
                // removing..
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
    }
}
