//
//  ProductItemView.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 19.05.2023.
//

import SwiftUI

struct ProductItemView: View {
    
    let product: ProductData
    
    var body: some View {
        
        VStack(spacing: .zero) {
            
            Button("AAAAAAA") {
                print(product.image) //data:image/webp;base64,UklGRs
            }
            
            Group {
                if let uiImage = convertBase64StringToImage(imageBase64String: product.image) {
                    let swiftUIImage = Image(uiImage: uiImage)
                    swiftUIImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150,height: 130)
                    //.clipped()
                    
                } else {
                    Text("Invalid Base64 String")
                }
            }
            
            VStack (alignment: .leading) {
                PillView(id: product.id ?? "Product ID")
                Text(product.name ?? "ProductName")
                    .font(.system(.body, design: .rounded))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 8)
            .padding(.vertical, 5)
            .background(Theme.darkWhite)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16,style: .continuous))
        .shadow(color: Color.green.opacity(0.5), radius: 2, x: 0, y: 1)
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

struct ProductItemView_Previews: PreviewProvider {
    
    static var preiewProduct : ProductData {
        let products = try! StaticJSONMapper.decode(file: "ProductsData", type: ProductsResponse.self)
        return products.data.first!
    }
    
    static var previews: some View {
        ProductItemView(product: preiewProduct).frame(width: 250)
    }
}
