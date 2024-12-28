//
//  Order.swift
//  ReLeaf
//
//  Created by Student on 25/12/2024.
//

import Foundation

struct Order: Codable {
    let id: String
    let userId: String
    let shopId: String
    let products: [OrderProduct]
    let total: Double
    let orderDate: String
    let status: String
}
