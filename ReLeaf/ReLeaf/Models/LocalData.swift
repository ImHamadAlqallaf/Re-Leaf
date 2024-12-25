//
//  LocalData.swift
//  ReLeaf
//
//  Created by Student on 25/12/2024.
//

import Foundation

struct LocalData: Codable {
    var reviews: [Review]
    let shops: [Shop]
    let users: [User]
    let orders: [Order]
}


