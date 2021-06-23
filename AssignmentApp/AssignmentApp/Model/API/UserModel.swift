//
//  UserModel.swift
//  AssignmentApp
//
//  Created by Blessy Saini on 6/23/21.
//

import Foundation

// MARK: - UserModelElement
struct UserModel: Codable {
    let userID, id: Int
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias UserActivitiesResponse = [UserModel]
