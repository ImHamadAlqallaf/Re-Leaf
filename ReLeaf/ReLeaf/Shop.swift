//
//  Shop.swift
//  ReLeaf
//
//  Created by BP-36-201-17 on 25/12/2024.
//

import UIKit

// Define models based on the JSON structure

// Product Model
struct Product: Codable {
    let id: String
    let name: String
    let price: Double
    let stock: Int
    let description: String
    let category: String
    let image: String
}

// Shop Model
struct Shop: Codable {
    let id: String
    let name: String
    let location: String
    let owner: String
    let contact: String
    let products: [Product]
}

// Root Model for the JSON structure
struct RootData: Codable {
    let reviews: [Review]
    let shops: [Shop]
    let users: [User]
    let orders: [Order]
    let metrics: Metrics
}

// Review Model
struct Review: Codable {
    let id: String
    let userName: String
    let productId: String
    let text: String
    let rating: Int
    let timestamp: String
}

// User Model
struct User: Codable {
    let id: String
    let userName: String
    let email: String
    let password: String
    let role: String
}

// Order Model
struct Order: Codable {
    let id: String
    let userId: String
    let shopId: String
    let products: [OrderProduct]
    let total: Double
    let orderDate: String
    let status: String
}

// OrderProduct Model
struct OrderProduct: Codable {
    let productId: String
    let quantity: Int
    let price: Double
}

// Metrics Model
struct Metrics: Codable {
    let impact: [Metric]
}

// Metric Model
struct Metric: Codable {
    let id: String
    let name: String
    let value: Double
    let timestamp: String
}



