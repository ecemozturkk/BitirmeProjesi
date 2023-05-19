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
    
    var body: some View {
        ZStack {
            background
            
            ScrollView {
                VStack(alignment: .leading,spacing: 18) {
                    Button("AAAAAAA") {
                        print(viewModel.productInfo?.data.image ?? "GELMİYOR")
                    }
                    
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
                        link
                    } .padding(.horizontal, 8)
                        .padding(.vertical, 18)
                        .background(Theme.darkWhite, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding()
            }
        }
        .navigationTitle("Details")
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
    
    var link: some View {
        
        Link(destination: .init(string: "www.xasdasd")!) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Takasla API")
                    .foregroundColor(.black)
                    .font(
                        .system(.body, design: .rounded)
                        .weight(.semibold)
                    )
                
                Text("https........")
            }
            Spacer()
            
            Image(systemName: "link").font(.system(.title3, design: .rounded))
        }
    }
}

private extension ProductDetailView {
    
    @ViewBuilder
    var productName: some View {
        Text("Product Name")
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
        Text("Description")
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
        Text("Username")
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
        Text("Location")
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
            PillView(id: viewModel.productInfo?.data.id ?? "id not found" )
            Group {
                productName
                productDescription
                username
                location
            }.foregroundColor(Color.black)
        }
        
    }
    
    
}
