//
//  CreateNewUserViewModel.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 15.05.2023.
//

import Foundation

class CreateNewUserViewModel: ObservableObject {
    let userService = UserService()
    
    @Published var isUserCreated = false

    
    func createUserPostMethod(firstName: String, lastName: String, email: String, password: String, rePassword: String, profileImage: String, location: String) {
        guard let url = URL(string: "http://localhost:6061/users") else {
            print("Error: cannot create URL")
            return
        }
        
        let createNewUserModel = CreateNewUserModel(firstName: firstName, lastName: lastName, email: email, password: password, rePassword: rePassword, profileImage: profileImage, location: location)
        
        guard let jsonData = try? JSONEncoder().encode(createNewUserModel) else {
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
        
            print(userData.tokens.accessToken!)
            
            isUserCreated = true
            
        } catch {
            print("Error: JSON decoding failed - \(error)")
        }
    }
}
