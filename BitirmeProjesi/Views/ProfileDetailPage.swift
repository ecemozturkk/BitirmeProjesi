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
        
        VStack(spacing: 0){
            

            
            ScrollView(.vertical, showsIndicators: false) {
                
                //MARK: Text
                Image("Ecem")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 130, height: 130)
                    .clipShape(Circle())
                Text("Ecem Öztürk")
                    .font(.custom(customFont, size: 28).bold())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top)
                    .padding(.horizontal,25)
                
                Spacer()
                
                HStack(spacing: 10){
                    Image(systemName: "location.fill")
                        .foregroundColor(.gray)
                    Text("Tekirdağ")
                        .font(.custom(customFont, size: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.offset(x: 160)
                
                Spacer()
                
                HStack(spacing: 10){
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                    Text("Ecem@gmail.com")
                        .font(.custom(customFont, size: 15))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.offset(x: 120)
                
                
                VStack (spacing: 0){
                    // MARK: Staggered Grid
                    StaggeredGrid(colums: 2, spacing: 20 ,list: homeData.userProducts) { product in
                        // MARK: Card View
                        ProductCardView(product: product)                        }
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
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
            .frame(width: 160, height: 170)
            .cornerRadius(50)
            .padding(.top, 10)
            
            Text(product.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            /*
            Text(product.brand)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.gray)
             */
            Text(product.usageLevel)
                .font(.custom(customFont, size: 14))
                .fontWeight(.medium)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(Theme.darkWhite.cornerRadius(25))
        .padding(.top, 10)
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
