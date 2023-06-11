//
//  ListPage.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 8.06.2023.
//

import SwiftUI

struct ListPage: View {

    @EnvironmentObject var sharedData: SharedDataModel
    
    // Delete option
    @State var showDeleteOption: Bool = false
    
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Giden Takas İstekleri")
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
                        // checking if liked products are empty..
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
                            // Displaying liked products..
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
                                        
                                        
                                        CardView(product: $product)
                                    }
                                }
                            }
                            .padding(.top, 25)
                            .padding(.horizontal)
                        }
                      
                    }
                    .padding()
                }
                
                // Showing Total and check out button
                if !sharedData.takasProducts.isEmpty {
                    Group {
                        HStack {
                            Text("Total")
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("$399")
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundColor(.purple)
                        }
                        
                        Button {
                            // getTotalPrice()
                        } label: {
                            Text ("Check Out")
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundColor(.white)
                                .padding(.vertical, 18)
                                .frame(maxWidth: .infinity)
                                .background(Color(.purple))
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.05), radius: 5,x:5,y:5)
                        }
                        .padding(.vertical)

                    }
                    .padding(.horizontal, 25)

                }
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
struct ListPage_Previews: PreviewProvider {
    static var previews: some View {
        ListPage()
    }
}

struct CardView: View {
    
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
                
                Text(product.brand)
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
}
