//
//  User.swift
//  ReLeaf
//
//  Created by Student on 25/12/2024.
//

import Foundation

struct User: Codable {
    let id: String
    var userName: String
    var number: String
    var email: String
    var password: String
    let role: String
}
