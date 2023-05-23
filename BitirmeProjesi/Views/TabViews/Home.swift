//
//  Home.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 16.05.2023.
//

import SwiftUI

struct Home: View {
    
    @Namespace var animation
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15){
                //MARK: Search Bar
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    TextField("Search", text: .constant(""))
                        .disabled(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color.gray, lineWidth: 0.8)
                )
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal, 25)
                
                
                //MARK: Text
                Text("Order online\ncollect in store")
                    .font(.custom(customFont, size: 28).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal,25)

                //MARK: Products Tab
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 18) {
                        ForEach(ProductType.allCases, id: \.self) { type in
                            // Product Type View
                            ProductTypeView(type: type)
                        }
                    }
                    .padding(.horizontal,25)
                }
                .padding(.top,28)
                
                // MARK: Products Page
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 25) {
                        ForEach(homeData.filteredProducts) { product in
                            // Product Card View
                            ProductCardView(product: product)
                            
                        }
                    }
                    .padding(.horizontal,25)
                    .padding(.bottom)
                    .padding(.top, 80)//Moving image to top to look like its fixed at half top

                }
                .padding(.top, 30)
                
                //MARK: "See More" button
                // This button will show all products on the current product type,
                // since here we're showing only 4
                Button {
                    homeData.showMoreProductsOnType.toggle()
                } label: {
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("See More")
                    }
                    .font(.custom(customFont, size: 18).bold())
                    .foregroundColor(.purple)
                }

             
                    
                
            }.padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("lightWhiteColor"))
        // Updating data whenever tab changes..
        .onChange(of: homeData.productType) { newValue in
            homeData.filterProductByType()
        }
        .sheet(isPresented: $homeData.showMoreProductsOnType) {
            //
        } content: {
            MoreProductsView()
        }
    }
    
     func ProductCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
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
        
    }
    
    
    @ViewBuilder func ProductTypeView(type: ProductType) -> some View {
        Button {
            //Updating current product type
            withAnimation {
                homeData.productType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
            // Changing color based on Current product type
                .foregroundColor(homeData.productType == type ? Color.purple : Color.gray)
                .padding(.bottom, 10)
            // Adding Indicator at the bottom
                .overlay(alignment: .bottom){
                    ZStack{
                        if homeData.productType == type {
                            Capsule()
                                .fill(.purple)
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        } else {
                            Capsule()
                                .fill(.clear)
                                .frame(height: 2)
                        }
                    }
                    .padding(.horizontal, -5)
                }
            

        }

    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//struct Home: View {
//
//    @ObservedObject var categoriesViewModel = CategoriesViewModel()
//    @State var filterCategory = ""
//    var category: CategoryResult?
//
//
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false) {
//            VStack(spacing: 15){
//                // Search Bar
//                HStack(spacing: 15) {
//                    Image(systemName: "magnifyingglass")
//                        .font(.title2)
//                        .foregroundColor(.gray)
//                    TextField("Search", text: .constant(""))
//                        .disabled(true)
//                }
//                .padding(.vertical, 12)
//                .padding(.horizontal)
//                .background(
//                    Capsule()
//                        .strokeBorder(Color.gray, lineWidth: 0.8)
//                )
//                .frame(width: getRect().width / 1.6)
//                .padding(.horizontal, 25)
//
//                Text("Order online\ncollect in store")
//                    .font(.custom(customFont, size: 28).bold())
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding(.top)
//                    .padding(.horizontal,25)
//            }.padding(.vertical)
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color("lightWhiteColor"))
//    }
//
//}
//
//struct Home_Previews: PreviewProvider {
//    static var previews: some View {
//        Home()
//    }
//}
//
