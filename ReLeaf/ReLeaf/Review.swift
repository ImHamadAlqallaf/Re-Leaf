//
//  Review.swift
//  ReLeaf
//
//  Created by BP-needchange on 15/12/2024.
//

import Foundation
import FirebaseFirestore

struct Review: Codable {
    let id: String
    let userName: String
    let text: String
    let rating: Int // Rating from 1 to 5
    let timestamp: Date
}
