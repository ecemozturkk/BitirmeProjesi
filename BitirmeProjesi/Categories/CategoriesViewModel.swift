//
//  CategoriesViewModel.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 17.05.2023.
//

import Foundation

class CategoriesViewModel: ObservableObject {
    let service = Service.shared
    
    @Published var categoriesResponse = [CategoryResult]()
    
    func initialize(filterCategory: String) {
        fetchContent(filterCategory: filterCategory)
    }
    
    func fetchContent(filterCategory: String) {
        service.fetchLocationRequest(filterCategory:filterCategory ,endpointType: endpointType.categories) { [weak self] (response: Result<CategoriesModel, ErrorType>) in
            switch response {
            case .success(let model):
                guard let results = model.results else { return }
                self?.categoriesResponse = results
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    
}
