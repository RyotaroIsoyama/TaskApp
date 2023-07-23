//
//  User.swift
//  TaskApp
//
//  Created by 久保田陽介 on 2023/07/07.
//

import Foundation

struct TempUser: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}

struct User: Codable {
    let id: String
    let name: String
    let email: String
    let profileImageURL: String
    let joined: TimeInterval
}
