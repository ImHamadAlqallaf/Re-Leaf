//
//  Shop.swift
//  ReLeaf
//
//  Created by Student on 25/12/2024.
//

import Foundation

struct Shop: Codable {
    let id: String
    let name: String
    let location: String
    let owner: String
    let contact: String
    let products: [Product]
}

struct Product: Codable {
    let id: String
    let name: String
    var price: Double // Prices might change
    var stock: Int // Stock levels change often
    let description: String
    let category: String
    let image: String
    var co2EmissionSaved: Double
    var waterConserved: Double
    var wasteReduced: Double
    var materialsUsed: String
    let certificateImage: String
}

// For handling products specifically
struct ProductLocalData: Codable {
    var shops: [Shop]
}
