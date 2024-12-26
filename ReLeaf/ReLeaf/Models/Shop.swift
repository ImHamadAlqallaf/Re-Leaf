//
//  Shop.swift
//  ReLeaf
//
//  Created by Student on 25/12/2024.
//

import Foundation

import Foundation

struct Shop: Codable {
    let id: String
    let name: String
    let location: String
    let owner: String
    let contact: String
    let products: [Product]
}

////struct Product: Codable {
//    let id: String
//    let name: String
//    let image: String
//    let price: Double
//}//

// For handling products specifically
struct ProductLocalData: Codable {
    var shops: [Shop]
}
