//
//  Notifs.swift
//  ReLeaf
//
//  Created by BP-36-224-15 on 28/12/2024.
//

import Foundation

struct Notification: Codable {
    let id: String
    let type: String
    let message: String
    let productId: String
    let timestamp: String
}
