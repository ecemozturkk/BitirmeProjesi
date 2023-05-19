//
//  ProductsViewModel.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 19.05.2023.
//

import Foundation

final class ProductsViewModel : ObservableObject {
    @Published private(set) var products: [ProductData] = []
    @Published private(set) var error: NetworkingManager.NetworkingError?
    @Published var hasError = false
    
    func fetchProducts() {
        NetworkingManager.shared.request("http://localhost:6061/products", type: ProductsResponse.self) { [weak self] res in
            
            DispatchQueue.main.async {
                switch res {
                case .success(let response):
                    self?.products = response.data
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? NetworkingManager.NetworkingError
                }
            }
        }
    }
}
