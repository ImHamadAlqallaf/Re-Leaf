//
//  UserManager.swift
//  ReLeaf
//
//  Created by BP-36-201-23 on 27/12/2024.
//

import Foundation

class UserManager {
    static let shared = UserManager()
    private init() {}
    
    var currentUser: User?
}
