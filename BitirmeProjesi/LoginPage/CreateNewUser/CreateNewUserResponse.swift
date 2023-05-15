//
//  CreateNewUserResponse.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 15.05.2023.
//

import Foundation

struct ResponseData: Codable {
    let success: Bool
    let data: UserResponseData
}

struct UserResponseData: Codable {
    let location: String
    let profileImage: String
    let firstName: String
    let rate: Int?
    let isAdmin: Bool?
    let id: String?
    let tokens: TokenData
    let email: String
    let updatedAt: String
    let createdAt: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case location
        case profileImage
        case firstName
        case rate
        case isAdmin
        case id = "_id"
        case tokens
        case email
        case updatedAt
        case createdAt
        case lastName
    }
}

struct TokenData: Codable {
    let refreshToken: String?
    let accessToken: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
