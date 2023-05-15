//
//  UserService.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 15.05.2023.
//

import Foundation

class UserService {
    func createURLRequest(url: URL, method: String, headers: [String: String], body: Data?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        for (headerField, value) in headers {
            request.setValue(value, forHTTPHeaderField: headerField)
        }
        request.httpBody = body
        return request
    }
    func sendRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "ResponseError", code: 0, userInfo: nil)))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
