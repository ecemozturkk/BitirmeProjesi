//
//  ProfileDetailPage.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 8.06.2023.
//

import SwiftUI

struct ProfileDetailPage: View {
    
    var animation: Namespace.ID
    
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    
    // Shared data
    @EnvironmentObject var sharedData: SharedDataModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15){
                
                //MARK: Text
                Text("Order online\ncollect in store")
                    .font(.custom(customFont, size: 28).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal,25)
                
                // MARK: Products Page
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25) {
                        ForEach(homeData.products) { product in
                            // Product Card View
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.horizontal,25)
                    .padding(.bottom)
                    .padding(.top, 80)//Moving image to top to look like its fixed at half top
                }
                .padding(.top, 30)
                
            }.padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("lightWhiteColor"))
    }
    
     @ViewBuilder func ProductCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            // Adding matched geometry effect
            ZStack {
                if sharedData.showDetailProduct {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                } else {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                }
            }
            .frame(width: 170, height: 170)
            .cornerRadius(50)
            //Moving image to top to look like its fixed at half top
            .offset(y: -80)
            .padding(.bottom, -80)
            
            Text(product.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            Text(product.subtitle)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.gray)
            Text(product.usageLevel)
                .font(.custom(customFont, size: 14))
                .fontWeight(.medium)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(Theme.darkWhite.cornerRadius(25))
         // Showing product detail when tapped
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
        
    }
}

struct ProfileDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        //ProfileDetailPage()
        //MainPageView()
        ProfilePage()
    }
}
