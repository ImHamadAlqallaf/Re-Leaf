import Foundation

// Store Model
import UIKit

struct Store: Codable {
    var id: String
    var storeName: String
    var storeEmail: String
    var storePassword: String
    var storePhoneNumber: String
    var storeDescription: String
    var storeOwner: String
    
    // This can be either a Base64 string or raw binary data
    var storeImage: String? // Base64 string for image
    var products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case id, storeName, storeEmail, storePassword, storePhoneNumber, storeDescription, storeOwner, storeImage, products
    }
    
    // Custom initializer for decoding
    init(id: String, storeName: String, storeEmail: String, storePassword: String, storePhoneNumber: String, storeDescription: String, storeOwner: String, storeImage: String?, products: [Product]) {
        self.id = id
        self.storeName = storeName
        self.storeEmail = storeEmail
        self.storePassword = storePassword
        self.storePhoneNumber = storePhoneNumber
        self.storeDescription = storeDescription
        self.storeOwner = storeOwner
        self.storeImage = storeImage
        self.products = products
    }
    
    // Decodes Base64 encoded image or returns nil if not available
    func decodedStoreImage() -> UIImage? {
        if let base64String = storeImage, let imageData = Data(base64Encoded: base64String) {
            return UIImage(data: imageData)
        }
        return nil
    }
}

// Wrapper Model
struct Wrapper: Codable {
    var stores: [Store]
    var reviews: [Review]?
    var metrics: [Metric]?
    
    enum CodingKeys: String, CodingKey {
        case stores
        case reviews
        case metrics
    }
}

// Review Model
struct Review: Codable {
    var reviewId: String?
    var storeId: String?
    var content: String?
    var rating: Int
    
    enum CodingKeys: String, CodingKey {
        case reviewId
        case storeId
        case content
        case rating
    }
}

// Product Model (assuming it's used for products within a store)
struct Product: Codable {
    var id: String
    var name: String
    var description: String
    var price: Double
}

// Metrics Model
struct Metrics: Codable {
    var impact: [Metric]
}

// Metric Model
struct Metric: Codable {
    let id: String
    let name: String
    let value: Double
    let timestamp: String
}
