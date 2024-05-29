//
//  User.swift
//  ThreadsTutorials
//
//  Created by MiniHsieh on 2024/5/17.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    let fullname: String
    let email: String
    let username: String
    var profileImageUrl: String?
    var bio: String?
    
    static var mockUser: User {
        return User(id: NSUUID().uuidString, fullname: "Taylor Alison Swift", email: "taylor@gmail.com", username: "Taylor")
    }
}
