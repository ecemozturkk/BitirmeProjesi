//
//  SwiftUIView.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 16.05.2023.
//

import SwiftUI

struct MainPageView: View {
    
    // Current Tab
    @State var currentTab: Tab = .Home
    
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    
    // Animation Namespace
    @Namespace var animation
    
    //Hiding Tab Bar
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        // MARK: -Tab View
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Home(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.Home)
                ProductsView().tag(Tab.Liked)
                ProfilePage().tag(Tab.Profile)
                Text("Cart").tag(Tab.Cart)
            }
            
            // Custom Tab Bar
            HStack(spacing: 0){
                ForEach(Tab.allCases, id: \.self) { tab in
                    Button {
                        //updating tab
                        currentTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .background(
                                Color.blue.opacity(0.1)
                                    .cornerRadius(5)
                                    .padding(-7)
                                    .blur(radius: 5)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color.blue : Color.black.opacity(0.3))
                            
                    }

                }
                
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
            
        }
        .background(Theme.lightWhite.ignoresSafeArea())
        .overlay {
            ZStack {
                // MARK: Detail page
                if let product = sharedData.detailProduct, sharedData.showDetailProduct {
                    ProductDetailViewKAVSOFT(product: product, animation: animation).environmentObject(sharedData)
                }
            }
        }
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}

// MARK: - Tab Cases
enum Tab: String, CaseIterable {
    // Raw value must be image Name in asset
    case Home = "Home"
    case Liked = "Liked"
    case Profile = "Profile"
    case Cart = "Cart"
}
