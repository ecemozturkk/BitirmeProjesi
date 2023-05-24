//
//  SearchView.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 24.05.2023.
//

import SwiftUI

struct SearchView: View {
    
    //var animation: Namespace.ID
    
    @EnvironmentObject var homeData: HomeViewModel
    
    // Activating Text Field with the help of FocusState
    @FocusState var startTF: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: Search bar
            HStack(spacing: 20) {
                // Close button
                Button {
                    withAnimation
                    {
                        homeData.searchActivated = false
                    }}
            label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundColor(.black.opacity(0.7))
            }
                
                // Search Bar
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
                //.matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing, 20)
            }
            .padding([.horizontal, .top])
            // MARK: Filter Results
            ScrollView(.vertical, showsIndicators: false) {
                // Staggered Grid
                StaggeredGrid(colums: 2, spacing: 20, list: homeData.products) { product in
                    // Card View
                    ProductCardView(product: product)
                    
                }
                .padding()
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
           Image(product.productImage)
               .resizable()
               .aspectRatio(contentMode: .fit)
               //.frame(width: 170, height: 170)
               .cornerRadius(50)
           //Moving image to top to look like its fixed at half top
               .offset(y: -50)
               .padding(.bottom, -50)
           
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
       .padding(.top, 50)
       
   }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView().environmentObject(HomeViewModel())
    }
}
