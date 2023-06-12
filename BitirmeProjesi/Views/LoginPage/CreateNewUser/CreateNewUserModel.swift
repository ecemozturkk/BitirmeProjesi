//
//  CreateNewUserModel.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 15.05.2023.
//

import Foundation

struct CreateNewUserModel: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let rePassword: String
    let profileImage: String
    let location: String
}
