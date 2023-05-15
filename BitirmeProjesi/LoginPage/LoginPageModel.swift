//
//  LoginPageModel.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 15.05.2023.
//

import SwiftUI

class LoginPageModel: ObservableObject {
    // Login Properties..
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword : Bool = false
    // Register Properties
    @Published var rePassword: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var profileImage: String = "-"
    @Published var location: String = ""
    
    //Other properties
    @Published var regsiterUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
  
    
    // Login Call
    func login () {
        UserService().login(email: email, password: password) { result in
            switch result {
            case .success(let token):
                print(token)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func register() {
        
            UserService().register(email: email, password: password, rePassword: rePassword, firstName: firstName, lastName: lastName, profileImage: profileImage, location: location) { result in
                switch result {
                case .success(let token):
                    print(token)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        

    }
    
    func ForgotPassword() {
        // Do action here
    }

    
}
