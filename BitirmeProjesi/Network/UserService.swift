//
//  UserService.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 15.05.2023.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}


class UserService {
    
    func login(email:String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void ) {
        
        
        guard let url = URL(string: "http://localhost:6061/users/login") else {
            completion(.failure(.custom(errorMessage: "Error: cannot create URL")))
            return
        }
        
        let loginUserModel = LoginUserModel(email: email, password: password) //body
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(loginUserModel)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let responseData = try? JSONDecoder().decode(ResponseData.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = responseData.data.tokens.accessToken else {
                completion(.failure(.invalidCredentials))
                return
            }
            //completion(.success(token)) //print(token)
            
        }.resume()
        
        
    }
    

    
    func register(email:String, password: String, rePassword: String ,firstName: String ,lastName: String,profileImage: String,location: String,completion: @escaping (Result<String, AuthenticationError>) -> Void ) {
        
        
        guard let url = URL(string: "http://localhost:6061/users") else {
            completion(.failure(.custom(errorMessage: "Error: cannot create URL")))
            return
        }
        
        let createUserModel = CreateNewUserModel(firstName: firstName, lastName: lastName, email: email, password: password, rePassword: rePassword, profileImage: profileImage, location: location)//body
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(createUserModel)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let responseData = try? JSONDecoder().decode(ResponseData.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            guard let token = responseData.data.tokens.accessToken else {
                completion(.failure(.invalidCredentials))
                return
            }
            //completion(.success(token)) //print(token)
            
        }.resume()
        
        
    }
    
       

}
