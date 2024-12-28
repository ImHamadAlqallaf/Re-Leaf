//
//  SessionManager.swift
//  ReLeaf
//
//  Created by Hussain Nader on 27/12/2024.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()
    
    private init() {} // Prevent external instantiation
    
    var currentUser: User? // Stores the logged-in user's data
}
