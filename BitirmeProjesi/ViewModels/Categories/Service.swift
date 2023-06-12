//
//  Service.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 17.05.2023.
//

import Foundation

class Service: ObservableObject {
    static let baseURL = "http://localhost:6060/"
    static let shared = Service()
    
  

    //MARK: - Request Location
    func fetchLocationRequest (filterCategory:String, endpointType: endpointType, completion: @escaping (Result<CategoriesModel, ErrorType>) -> ()) {
        
        let url = Service.baseURL + endpointType.apiTypeString + filterCategory

        guard let requestURL = URL(string: url) else {
            completion(.failure(.urlError))
            return
        }

        let task = URLSession.shared.dataTask(with: requestURL) { data, resp, err in

            guard let httpResponse = resp as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.responseError))
                return
            }

            guard let data = data else {
                completion(.failure(.dataError))
                return
            }

            do {
                let response = try JSONDecoder().decode(CategoriesModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response))
                    print(response)
                }
            }
            catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
}

enum endpointType {
    case users
    case products
    case categories

    var apiTypeString: String {
        switch self {
        case .users:
            return "users"
        case .products:
            return "products"
        case .categories:
            return "categories"
        }
    }
}

enum ErrorType: Error {

    case decodingError
    case dataError
    case urlError
    case responseError

    var localizedDescription: String {

        switch self {
        case .decodingError:
            return "Decode error"
        case .dataError:
            return "Data error"
        case .urlError:
            return "URL error"
        case .responseError:
            return "Response error"
        }
    }
}
