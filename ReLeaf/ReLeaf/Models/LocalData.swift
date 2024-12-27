//
//  LocalData.swift
//  ReLeaf
//
//  Created by Student on 25/12/2024.
//

import Foundation

struct LocalData: Codable {
    var reviews: [Review]
    var shops: [Shop]
    var users: [User]
    var orders: [Order]
    var metrics: Metrics
}


