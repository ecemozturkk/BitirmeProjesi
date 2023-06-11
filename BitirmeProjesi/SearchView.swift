//
//  SearchView.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 24.05.2023.
//

import SwiftUI

struct SearchView: View {
    
    var animation: Namespace.ID
    
    // Shared data
    @EnvironmentObject var sharedData: SharedDataModel
    
    @EnvironmentObject var homeData: HomeViewModel
    
    // Activating Text Field with the help of FocusState
    @FocusState var startTF: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: Search bar
            HStack(spacing: 20) {
                // MARK: Close button
                Button {
                    withAnimation
                    {
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    // RESETTING..
                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(.black.opacity(0.7))
                }
                
                // MARK: Search Bar
                HStack(spacing: 15) {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    TextField("Search", text: $homeData.searchText)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                        .focused($startTF)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color.purple, lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
            }
            .padding([.horizontal, .top])
            .padding(.bottom,10)
            
            // Showing Progress if searching
            // Else showing "no result" image
            if let products = homeData.searchedProducts {
                if products.isEmpty {
                    // No results found
                    VStack(spacing: 10) {
                        Image("notFound")
                            .resizable()
                            .offset(x: 50)
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 60)
                        Text("Item Not Found")
                            .font(.custom(customFont, size: 22).bold())
                        Text("Try a more generic search term or try looking for alternative products.")
                            .font(.custom(customFont, size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                        
                    }
                    .padding()
                    
                } else {
                    // MARK: Filter Results
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack (spacing: 0){
                            // MARK: ".. Found" text
                            Text("Found \(products.count) results")
                                .font(.custom(customFont, size: 24).bold())
                                .padding(.vertical)
                            // MARK: Staggered Grid
                            StaggeredGrid(colums: 2, spacing: 20, list: products) { product in
                                // MARK: Card View
                                ProductCardView(product: product)
                            }
                        }.padding()
                    }
                }
            } else {
                ProgressView()
                    .padding(.top, 30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Theme.lightWhite
                .ignoresSafeArea()
        )
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
            {
                startTF = true
            }
        }
    }
    @ViewBuilder func ProductCardView(product: Product) -> some View {
        VStack(spacing: 10) {
            ZStack {
                if sharedData.showDetailProduct {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    //.frame(width: 170, height: 170)
                        .cornerRadius(50)
                        .opacity(0)
                } else {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    //.frame(width: 170, height: 170)
                        .cornerRadius(50)
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
            //Moving image to top to look like its fixed at half top
            .offset(y: -50)
            .padding(.bottom, -50)
            
            Text(product.title)
                .font(.custom(customFont, size: 18))
                .fontWeight(.semibold)
                .padding(.top)
            Text(product.brand)
                .font(.custom(customFont, size: 14))
                .foregroundColor(.gray)
            Text(product.usageLevel)
                .font(.custom(customFont, size: 14))
                .fontWeight(.medium)
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 22)
        .background(Theme.darkWhite.cornerRadius(25))
        .padding(.top, 50)
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
