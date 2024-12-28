//
//  LocalData.swift
//  ReLeaf
//
//  Created by Student on 25/12/2024.
//

import Foundation

struct LocalData: Codable {
    var reviews: [Review]
    var stores: [Store]
    var users: [User]
    var orders: [Order]
    var metrics: Metrics
    var cartItems: [CartItem]
    let notifications: [Notification]
}


