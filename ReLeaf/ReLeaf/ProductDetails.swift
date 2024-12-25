//
//  ProductDetails.swift
//  ReLeaf
//
//  Created by Guest User on 25/12/2024.
//

import Foundation

struct Product:Codable {
    var id: String
    var name: String
    var price: Double
    var stock: Int
    var description: String
    var category: String
    var image: String  // Image filename or URL for the product
}
