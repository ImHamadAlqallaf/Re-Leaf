//
//  Review.swift
//  ReLeaf
//
//  Created by BP-needchange on 15/12/2024.
//

import Foundation

struct Review: Codable {
    let id: String
    let userName: String
    let productID: String?
    let text: String
    let rating: Int  // Rating from 1 to 5
    let timestamp: Date
}

struct ReviewLocalData: Codable {
    var reviews: [Review]
}

class ReviewLocalDataService {
    static let shared = ReviewLocalDataService()
    private let fileName = "localData.json"
    private var data: ReviewLocalData = ReviewLocalData(reviews: [])
    
    private init() {
        ensureDataFileExists()
        loadDataFromDisk()
        print("✅ ReviewLocalDataService Initialized Successfully")
    }

    
    private func getFileURL() -> URL {
//        print("📂 JSON File Path: \(getFileURL().path)")
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(fileName)
        

    }
    
//    private func ensureDataFileExists() {
//        let fileURL = getFileURL()
//        let fileManager = FileManager.default
//        
//        if !fileManager.fileExists(atPath: fileURL.path) {
//            if let bundleURL = Bundle.main.url(forResource: fileName, withExtension: nil) {
//                do {
//                    try fileManager.copyItem(at: bundleURL, to: fileURL)
//                    print("📦 Copied initial review data to document directory.")
//                } catch {
//                    print("❌ Failed to copy review data: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
    
    private func ensureDataFileExists() {
        let fileURL = getFileURL()
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: fileURL.path) {
            if let bundleURL = Bundle.main.url(forResource: fileName, withExtension: nil) {
                do {
                    try fileManager.copyItem(at: bundleURL, to: fileURL)
                    print("📦 Copied initial review data to document directory.")
                } catch {
                    print("❌ Failed to copy review data: \(error.localizedDescription)")
                }
            }
        }
    }
    
//    private func loadDataFromDisk() {
//        let fileURL = getFileURL()
//        
//        do {
//            let jsonData = try Data(contentsOf: fileURL)
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .iso8601
//            self.data = try decoder.decode(ReviewLocalData.self, from: jsonData)
//            print("✅ Successfully loaded review data from disk")
//        } catch {
//            print("❌ Failed to load review data: \(error.localizedDescription)")
//        }
//    }
    
    private func loadDataFromDisk() {
        let fileURL = getFileURL()
        print("📥 Loading JSON from path: \(fileURL.path)")

        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            self.data = try decoder.decode(ReviewLocalData.self, from: jsonData)
            print("✅ Successfully loaded review data from disk")
        } catch {
            print("❌ Failed to load review data: \(error.localizedDescription)")
        }
    }


    
    func getReviews() -> [Review] {
        print("📊 Fetching reviews, current count: \(data.reviews.count)")
        return data.reviews.sorted { $0.timestamp > $1.timestamp }
    }

    func addReview(_ review: Review) {
        data.reviews.append(review)
        saveDataToDisk()
        print("✅ Review added and saved to disk")
    }
    
    func calculateAverageRating() -> Double {
        guard !data.reviews.isEmpty else { return 0.0 }
        let totalRating = data.reviews.reduce(0) { $0 + $1.rating }
        return Double(totalRating) / Double(data.reviews.count)
    }
    
//    private func saveDataToDisk() {
//        let fileURL = getFileURL()
//        do {
//            let jsonData = try JSONEncoder().encode(self.data)
//            try jsonData.write(to: fileURL, options: .atomicWrite)
//            print("✅ Successfully saved review data to disk.")
//        } catch {
//            print("❌ Failed to save review data: \(error.localizedDescription)")
//        }
//    }
    
    private func saveDataToDisk() {
        let fileURL = getFileURL()
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601 // Ensure ISO8601 date format
            let jsonData = try encoder.encode(self.data)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("📝 JSON Data Written to Disk:\n\(jsonString)")
            }
            try jsonData.write(to: fileURL, options: .atomicWrite)
            print("✅ Successfully saved review data to disk at \(fileURL.path).")
        } catch {
            print("❌ Failed to save review data: \(error.localizedDescription)")
        }
    }

}

