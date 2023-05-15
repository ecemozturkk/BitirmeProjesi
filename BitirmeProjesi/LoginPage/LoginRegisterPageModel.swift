//
//  LoginPageModel.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 15.05.2023.
//

import SwiftUI

class LoginRegisterPageModel: ObservableObject {
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
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    // Authentication
    @Published var isAuthenticated: Bool = false
    
    

    
    // Login Call
    func login () {
        
        let defaults = UserDefaults.standard
        
        UserService().login(email: email, password: password) { result in
            switch result {
            case .success(let token):
                // save the token
                defaults.setValue(token, forKey: "jsonwebtoken")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func register() {
        
        let defaults = UserDefaults.standard
        
            UserService().register(email: email, password: password, rePassword: rePassword, firstName: firstName, lastName: lastName, profileImage: profileImage, location: location) { result in
                switch result {
                case .success(let token):
                    defaults.setValue(token, forKey: "jsonwebtoken")
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        

    }
    
    func ForgotPassword() {
        // Do action here
    }

    
}
