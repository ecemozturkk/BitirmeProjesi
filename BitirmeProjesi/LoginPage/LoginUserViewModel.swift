//
//  LoginUserViewModel.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 15.05.2023.
//

import Foundation

import Foundation

class LoginUserViewModel: ObservableObject {
    let userService = UserService()
    
    @Published var isUserCreated = false

    
    func loginUserPostMethod(email: String, password: String) {
        guard let url = URL(string: "http://localhost:6061/users/login") else {
            print("Error: cannot create URL")
            return
        }

        let loginUserModel = LoginUserModel(email: email, password: password)

        guard let jsonData = try? JSONEncoder().encode(loginUserModel) else {
            print("Error: Trying to convert model to JSON data")
            return
        }

        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]

        let request = userService.createURLRequest(url: url, method: "POST", headers: headers, body: jsonData)

        userService.sendRequest(request: request) { result in
            switch result {
            case .success(let data):
                self.handleResponse(data: data)
            case .failure(let error):
                print("Error: \(error)")
            }
        }

    }
    
    func handleResponse(data: Data) {
        do {
            let decoder = JSONDecoder()
            let responseData = try decoder.decode(ResponseData.self, from: data)
            let userData = responseData.data
            
            isUserCreated = true
            
            print(userData.tokens.accessToken!)
            
        } catch {
            print("Error: JSON decoding failed - \(error)")
        }
    }
}
