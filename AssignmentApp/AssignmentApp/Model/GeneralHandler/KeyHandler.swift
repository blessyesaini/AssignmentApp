//
//  KeyHandler.swift
//  AssignmentApp
//
//  Created by Blessy Saini on 6/24/21.
//

import Foundation

enum Controllers: String {
   
    case userListVieController = "UsersListViewController"
    case formViewController = "FormViewController"
    func getName() -> String {
        return self.rawValue
    }
}
