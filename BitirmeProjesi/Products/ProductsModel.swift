//
//  ProductsModel.swift
//  BitirmeProjesi
//
//  Created by Ecem Öztürk on 19.05.2023.
//

import UIKit

// MARK: - ProductsModel
struct ProductsModel : Codable { //ProductDetailResponse
    let success: Bool
    let data: ProductData
}

// MARK: - ProductData
struct ProductData: Codable {
    let id: String?
    let userId: UserID
    let name: String?
    let description: String?
    let image: String
    let categoryId: [CategoryID]
    let usageLevel: Int?
    let tags: [String]
    let incomingOffers: [IncomingOffer]?
    let acceptedCategories: [AcceptedCategory]
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId, name, description, image, categoryId, usageLevel, tags, incomingOffers, acceptedCategories, createdAt, updatedAt
    }
}
// MARK: - IncomingOffer
struct IncomingOffer: Codable {
    let id, advertiserUser, advertiserProducts, applicantUser: String
    let applicantProducts: String
    let isAccepted: Bool
    let status: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case advertiserUser, advertiserProducts, applicantUser, applicantProducts, isAccepted, status, createdAt, updatedAt
    }
}

// MARK: - UserID
struct UserID: Codable {
    let id: String?
    let firstName: String?
    let lastName: String?
    let email: String?
    let profileImage : String?
    let location: String?
    let rate: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case firstName, lastName, email, profileImage, location, rate
    }
}

// MARK: - CategoryID
struct CategoryID: Codable {
    let id, name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}

// MARK: - AcceptedCategory
struct AcceptedCategory: Codable {
    let id, name: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name
    }
}

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self) {
            return UIImage(data: data)
        }
        return nil
    }
}
