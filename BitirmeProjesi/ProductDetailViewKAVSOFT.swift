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
    
    @State private var isProfileDetailPagePresented = false

    // Shared data model
    @EnvironmentObject var sharedData : SharedDataModel
    //@StateObject var sharedData: SharedDataModel = SharedDataModel()

    
    
    @EnvironmentObject var homeData: HomeViewModel
    
    @State private var showActivityIndicator = false

    
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
                        addToLiked()
                    } label: {
                        Image(systemName: "heart.fill")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(isLiked() ?.red : Color.black.opacity(0.7))
                        
                    }
                }
                .padding()
                
                
                // Product Image
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .frame(maxHeight: getRect().height / 4)
                
            }
            .frame(height: getRect().height / 2.7)
            .padding(.top, 10)
            .zIndex(1)
            
            
            // MARK: product details
            ScrollView(.vertical, showsIndicators: false) {
                // Product data
                VStack (alignment: .leading, spacing: 15) {
                    // Product title
                    Text(product.title)
                        .font(.custom(customFont, size: 25).bold())
                    
                    HStack {
                        Image(product.profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        //.offset(y: -30)
                        //.padding(.bottom, -30)
                        
                        Text(product.nameSurname)
                            .font(.custom(customFont, size: 20))
                            .onTapGesture {
                                    isProfileDetailPagePresented = true
                                }
                                .sheet(isPresented: $isProfileDetailPagePresented) {
                                    ProfileDetailPage(animation: animation).environmentObject(sharedData)
                                }
                    }
                        
                    // Product brand
                    Text(product.brand)
                        .font(.custom(customFont, size: 18))
                        .foregroundColor(.gray)
                    // Product usage level
                    Text(product.usageLevel)
                        .font(.custom(customFont, size: 16))
                    // Product description
                    Text(product.description)
                        .font(.custom(customFont, size: 15))
                    
                    // MARK: Takas isteği Button
                    Button(action: {
                        showActivityIndicator = true
                        addToList()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            showActivityIndicator = false
                        }
                    }) {
                        if showActivityIndicator {
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    ProgressView()
                                        .frame(width: 30, height: 30)
                                        .padding(.vertical, 15)
                                    Spacer()
                                }
                                Spacer()
                            }
                        } else {
                            Text(isAddedToList() ? "İstek Gönderildi" : "Takas İsteği Gönder")
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
            .zIndex(0)
            .padding(.top,40)
        }
        .animation(.easeInOut, value: sharedData.likedProducts)
        .animation(.easeInOut, value: sharedData.takasProducts)
        .background(Theme.darkWhite).ignoresSafeArea()
    }
    
    func isLiked() -> Bool {
        return sharedData.likedProducts.contains { product in
            return self.product.id == product.id
            
        }
    }
    func isAddedToList() -> Bool {
        return sharedData.takasProducts.contains { product in
            return self.product.id == product.id
            
        }
    }
    
    func addToLiked() {
        if let index = sharedData.likedProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }) {
            // Remove from liked
            sharedData.likedProducts.remove(at: index)
        } else {
            // add to liked
            sharedData.likedProducts.append(product)
        }
    }
    
    func addToList() {
        if let index = sharedData.takasProducts.firstIndex(where: { product in
            return self.product.id == product.id
        }) {
            // Remove from liked
            sharedData.takasProducts.remove(at: index)
        } else {
            // add to liked
            sharedData.takasProducts.append(product)
        }
    }
}



struct ProductDetailViewKAVSOFT_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
