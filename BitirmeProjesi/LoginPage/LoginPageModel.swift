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
    
    //Register properties
    @Published var regsiterUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showReEnterPassword: Bool = false
    
    // Login Call
    func Login () {
        // Do action here...
    }
    
    func Register() {
        // Do action here...

    }
    
    func ForgotPassword() {
        // Do action here
    }

    
}
