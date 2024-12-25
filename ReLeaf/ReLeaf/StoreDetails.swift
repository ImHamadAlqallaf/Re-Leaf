//
//  StoreDetails.swift
//  ReLeaf
//
//  Created by Guest User on 25/12/2024.
//

import Foundation


struct Store:Codable {
    var id: String
    var storeName: String
    var storeEmail: String
    var storePassword: String
    var storePhoneNumber: String
    var storeDescription: String
    var storeOwner: String
    var products: [Product]  // Array of products for the store
}
