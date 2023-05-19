//
//  ProductDetailsViewModel.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 19.05.2023.
//

import Foundation

final class ProductDetailsViewModel: ObservableObject {
    
    @Published private(set) var productInfo: ProductsModel?
    
    func fetchProductDetails(for id: String) {
        NetworkingManager.shared.request("http://localhost:6061/products/\(id)", type: ProductsModel.self) { [weak self] res in
            
            DispatchQueue.main.async {
                switch res {
                case .success(let response):
                    self?.productInfo = response
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
