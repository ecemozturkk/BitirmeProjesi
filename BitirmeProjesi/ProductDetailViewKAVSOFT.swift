//
//  ProductDetailViewKAVSOFT.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 29.05.2023.
//

import SwiftUI

struct ProductDetailViewKAVSOFT: View {
    
    var product: Product
    
    //For Matched Geometry Effect
    var animation: Namespace.ID
    
    
    // Shared data model
    @EnvironmentObject var sharedData : SharedDataModel
    var body: some View {
        
        VStack {
            
            // MARK: Title bar and product image
            VStack {
                Spacer()
                
                // Title bar
                HStack {
                    // Back button
                    Button {
                        withAnimation (.easeInOut) {
                            sharedData.showDetailProduct = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    // Like button
                    Button {
                        //ahsjd
                    } label: {
                        Image(systemName: "heart.fill")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(Color.black.opacity(0.7))
                        
                    }
                }
                .padding()
                
                
                // Product Image
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                    .padding(.horizontal)
                    .frame(maxHeight: getRect().height / 4)
                
            }
            .frame(height: getRect().height / 2.7)
            .padding(.top, 10)
            
            
            // MARK: product details
            ScrollView(.vertical, showsIndicators: false) {
                // Product data
                VStack (alignment: .leading, spacing: 15) {
                    // Product title
                    Text(product.title)
                        .font(.custom(customFont, size: 20).bold())
                    // Product subtitle
                    Text(product.subtitle)
                        .font(.custom(customFont, size: 18))
                        .foregroundColor(.gray)
                    // Product usage level
                    Text(product.usageLevel)
                        .font(.custom(customFont, size: 16))
                    // Product description
                    Text(product.description)
                        .font(.custom(customFont, size: 15))
                    
                    // Takas button
                    Button {
                        //
                    } label: {
                        Text("Takas İsteği Gönder")
                            .font(.custom(customFont, size: 20).bold())
                            .padding(.vertical, 20)
                            .frame(maxWidth:.infinity)
                            .foregroundColor(.white)
                            .background(
                                Color(.purple)
                                    .cornerRadius(25)
                                    .shadow(color: Color.black.opacity(0.3), radius: 25, x: 5, y: 5)
                            )
                    }
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 25)
                .frame(maxWidth: .infinity, alignment: .leading)
                    
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                //Corner radius for only top side
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .padding(.top,40)
        }
        .background(Theme.darkWhite).ignoresSafeArea()
    }
}



struct ProductDetailViewKAVSOFT_Previews: PreviewProvider {
    static var previews: some View {
        //ProductDetailViewKAVSOFT(product: HomeViewModel().products[0]).environmentObject(SharedDataModel())
        MainPageView()
    }
}
