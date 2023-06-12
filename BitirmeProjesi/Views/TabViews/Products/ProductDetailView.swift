//
//  ProductDetailView.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 19.05.2023.
//

import SwiftUI

struct ProductDetailView: View {
    let productId : String
    @StateObject private var viewModel = ProductDetailsViewModel()
    
    @State private var showActivityIndicator = false

    
    var body: some View {
        ZStack {
            background
            
            ScrollView {
                VStack(alignment: .leading,spacing: 18) {
                    Group {
                        if let uiImage = convertBase64StringToImage(imageBase64String: viewModel.productInfo?.data.image ?? "BULUNAMADI") {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 250)
                                .clipped()
                        } else {
                            ZStack {
                                Color.gray // Placeholder olarak gri bir renk kullanıyoruz
                                Text("Invalid Base64 String")
                            }
                            .frame(height: 250)
                        }
                    }.clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    
                    
                    Group {
                        general
                    } .padding(.horizontal, 8)
                        .padding(.vertical, 18)
                        .background(Theme.darkWhite, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                    // MARK: Takas isteği Button
                    Button(action: {
                        showActivityIndicator = true
                        
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

                }
                .padding()
            }
        }
        .navigationTitle("Ürün Detayı")
        .onAppear{
            viewModel.fetchProductDetails(for: productId)
        }
    }
    
    func convertBase64StringToImage(imageBase64String: String) -> UIImage? {
        let temp = imageBase64String.components(separatedBy: ",")
        if temp.count > 1, let dataDecoded = Data(base64Encoded: temp[1], options: .ignoreUnknownCharacters) {
            let decodedimage = UIImage(data: dataDecoded)
            //print(temp)
            return decodedimage
        }
        return nil
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    
    private static var previewProductId: String {
        let products = try! StaticJSONMapper.decode(file: "ProductsData", type: ProductsResponse.self)
        return products.data.first!.id! // .id şeklinde yazdı videoda
    }
    
    static var previews: some View {
        NavigationView{
            ProductDetailView(productId: previewProductId)
        }
    }
}

private extension ProductDetailView {
    var background: some View {
        Theme.lightWhite.ignoresSafeArea(edges: .top)
    }
}

private extension ProductDetailView {
    
    @ViewBuilder
    var productName: some View {
        Text("Ürün Adı ")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        Text(viewModel.productInfo?.data.name ?? "Product name not found")
            .font(.system(.subheadline, design: .rounded))
        Divider()
    }
    
    @ViewBuilder
    var productDescription: some View {
        Text("Ürün Açıklaması")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        Text(viewModel.productInfo?.data.description ?? "Description not found")
            .font(.system(.subheadline, design: .rounded))
        Divider()
    }
    
    @ViewBuilder
    var username : some View {
        Text("Kullanıcı Adı Soyadı")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        
        HStack {
            Text(viewModel.productInfo?.data.userId.firstName ?? "User first name not found")
            Text(viewModel.productInfo?.data.userId.lastName ?? "User last name not found")
        }.font(.system(.subheadline, design: .rounded))
        
        Divider()
    }
    
    @ViewBuilder
    var location : some View {
        Text("Konum")
            .font(
                .system(.body, design: .rounded)
                .weight(.semibold)
            )
        Text(viewModel.productInfo?.data.userId.location ?? "Location not found")
            .font(.system(.subheadline, design: .rounded))
    }

    
    @ViewBuilder
    var general: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Group {
                productName
                productDescription
                username
                location
            }.foregroundColor(Color.black)
        }
        
    }
    
    
}
