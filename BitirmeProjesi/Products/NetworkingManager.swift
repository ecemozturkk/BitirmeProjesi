//
//  NetworkingManager.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 19.05.2023.
//

import Foundation

final class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {}
    
    func request<T: Codable> (methodType: MethodType = .GET, _ absoluteURL: String, type:T.Type, completion: @escaping (Result<T, Error>) -> Void ) {
        
        guard let url = URL(string: absoluteURL) else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }
        
        let request = buildRequest(from: url, methodType: methodType)
        
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                
                      return
                  }
            guard let data = data else {
                completion(.failure(NetworkingError.invalidData))
                print(completion)
                return
            }
            do {
                let decoder = JSONDecoder()
                let res = try decoder.decode(T.self, from: data)
                print(res)
                completion(.success(res))
            } catch {
                completion(.failure(NetworkingError.failedToDecode(error: error)))
            }
            
        }
        
        dataTask.resume()
    }
    
    func request (methodType: MethodType = .GET, _ absoluteURL: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: absoluteURL) else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }
        
        let request = buildRequest(from: url, methodType: methodType)

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                      return
                  }
            completion(.success(()))
        }
        
        dataTask.resume()
    }
}

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidURL
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "Invalid URL"
            case .custom(let error):
                return error.localizedDescription
            case .invalidStatusCode(let statusCode):
                return "Invalid status code: \(statusCode)"
            case .invalidData:
                return "Invalid data"
            case .failedToDecode(let error):
                print(error)
                return "Failed to decode data: \(error.localizedDescription)"
            }
        }
    }

        
}

extension NetworkingManager {
    enum MethodType {
        case GET
        case POST(data: Data?)
    }
}

private extension NetworkingManager {
    func buildRequest(from url: URL, methodType: MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
}
