//
//  Home.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 16.05.2023.
//

import SwiftUI

struct Home: View {
    
    @ObservedObject var categoriesViewModel = CategoriesViewModel()
    @State var filterCategory = ""
    var category: CategoryResult?
    
    @State private var selectedButtonIndex: Int?
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15){
                // Search Bar
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
                
                Text("Order online\ncollect in store")
                    .font(.custom(customFont, size: 28).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top)
                    .padding(.horizontal,25)
               

                
                // Categories
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(Array(categoriesViewModel.categoriesResponse.indices), id: \.self) { index in
                            Button(action: {
                                selectedButtonIndex = index
//                                let locationResidents = locationViewModel.locationResponse[index].residents
//                                let ids = locationResidents?
//                                    .compactMap { URL(string: $0)?.lastPathComponent }
//                                    .joined(separator: ",")
//                                locationDetailViewModel.fetchCharactersbyIds(ids: ids!)
                            }) {
                                VStack(spacing: 10) {
                                    Text(categoriesViewModel.categoriesResponse[index].name ?? "DefaultLocationName")
                                        .foregroundColor(selectedButtonIndex == index ? Color("colorDarkGreen") : Color("colorLightGreen"))
                                        .font(.custom("Avenir", size: 20))
                                        .bold()
                                        .padding(.horizontal)
                                    Capsule()
                                        .fill(selectedButtonIndex == index ? Color("colorDarkGreen") : .clear)
                                        .frame(height: 3)
                                        .padding(.horizontal, -10)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }.padding(.top, 28)
                
            }.padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("lightWhiteColor"))
        .onAppear {
            categoriesViewModel.initialize(filterCategory: filterCategory)
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
