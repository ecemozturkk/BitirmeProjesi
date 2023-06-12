//
//  ProfilePage.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 29.05.2023.
//

import SwiftUI

struct ProfilePage: View {
    
    //@StateObject var sharedData: SharedDataModel = SharedDataModel()
    //Gelen Takas istekleri için:
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    
    // Animation Namespace
    @Namespace var animation
    
    @AppStorage("log_status") var log_status: Bool = false
    var body: some View {
        
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    Text("Hesap")
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    VStack(spacing: 15){
                        Image("Ecem")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        Text("Ecem Öztürk")
                            .font(.custom(customFont, size: 20))
                            .fontWeight(.semibold)
                      
                        
                    }
                    .padding([.horizontal, .bottom])
                    .background(
                        Theme.darkWhite
                            .cornerRadius(12)
                    )
                    .padding()
                    .padding(.top, 25)
                    
                    customNavigationLink(title: "Profil Sayfam"){
                        ProfileDetailPage(animation: animation)
                            .environmentObject(sharedData)
                    }
                    
                    customNavigationLink(title: "Gelen Takas İsteklerim"){
                        IncomingOffers()
                            .environmentObject(sharedData)
                    }
                    
                    customNavigationLink(title: "Hesabımı Düzenle"){
                        ListPage()
                            .environmentObject(sharedData)

                    }

                    customNavigationLink(title: "Bildirimler"){
                        Text("")
                            .navigationTitle("Notifications")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                            Button{
                                log_status.toggle()
                            } label: {
                                HStack(spacing: 10){
                                Text("Sign out")
                                    .font(.custom(customFont, size: 17).bold())
                                    
                                }
                                Image(systemName: "person.fill.xmark")
                                    .font(.system(size: 15))
                            }
                            .opacity(0.9)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.red)
                            .padding()
                            .background(
                                Theme.darkWhite
                                    .cornerRadius(12)
                            )
                            .padding(.horizontal)
                            .padding(.top, 20)
                }
                .padding(.horizontal, 22)
                .padding(.vertical, 10)
                
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("HomeBG").ignoresSafeArea())
            .overlay {
                ZStack {
                    // MARK: Detail page
                    if let product = sharedData.detailProduct, sharedData.showDetailProduct {
                        ProductDetailViewKAVSOFT(product: product, animation: animation).environmentObject(sharedData)
                        // Adding transitions
                            .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                    }
                }
            }.background(Theme.lightWhite)
     
        }

    }
    @ViewBuilder
    func customNavigationLink<Detail: View>(title: String, @ViewBuilder content: @escaping () -> Detail) -> some View{
        NavigationLink {
            content()
        } label: {
            Text(title)
                .font(.custom(customFont, size: 17))
                .fontWeight(.semibold)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .foregroundColor(.black)
        .padding()
        .background(
            Theme.darkWhite
                .cornerRadius(12)
        )
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}

struct CustomNavigationLink<Label, Destination>: View where Label: View, Destination: View {
    let label: Label
    let destination: Destination
    let title: String
    
    init(title: String, @ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
        self.title = title
        self.destination = destination()
        self.label = label()
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
            label
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    private var backButton: some View {
        Button(action: {
            // Geri tuşuna tıklama işlemi
        }) {
            HStack {
                Image(systemName: "chevron.left")
                Text(title)
            }
        }
    }
}
