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
    let productID: String
    let text: String
    let rating: Int // Rating from 1 to 5
    let timestamp: Date
}

struct LocalData: Codable {
    var reviews: [Review]
}

// MARK: - Local Data Service
class LocalDataService {
    static let shared = LocalDataService()
    private let fileName = "localData.json"
    private var data: LocalData = LocalData(reviews: [])
    
    private init() {
        loadDataFromDisk()
    }
    
    private func getFileURL() -> URL {
        // Get the URL of the document directory
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(fileName)
    }
    
    
    private func ensureDataFileExists() {
        let fileURL = getFileURL()
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: fileURL.path) {
            // If the file does not exist, copy it from the bundle to the document directory
            if let bundleURL = Bundle.main.url(forResource: fileName, withExtension: nil) {
                do {
                    try fileManager.copyItem(at: bundleURL, to: fileURL)
                    print("📦 Copied initial data to document directory.")
                } catch {
                    print("❌ Failed to copy initial data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - Load Data
    private func loadDataFromDisk() {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            print("❌ Failed to locate \(fileName) in bundle.")
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
                    let jsonString = String(data: jsonData, encoding: .utf8) ?? "Invalid JSON"
                    print("📄 Raw JSON Content: \(jsonString)")
                    
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601 // Explicitly set date decoding strategy
            
            self.data = try decoder.decode(LocalData.self, from: jsonData)
            print("✅ Successfully loaded data from \(fileName)")
        } catch {
            print("❌ Failed to load data: \(error.localizedDescription)")
        }
    }
        
        
        
        // MARK: - Get Reviews
        func getReviews() -> [Review] {
            print("📊 Fetching reviews, current count: \(data.reviews.count)")
            return data.reviews.sorted { $0.timestamp > $1.timestamp }
        }
        
        // MARK: - Add Review
        func addReview(_ review: Review) {
            data.reviews.append(review)
            saveDataToDisk()
            print("✅ Review added to local data array and saved to disk")
        }
        
        // MARK: - Calculate Average Rating
        func calculateAverageRating() -> Double {
            guard !data.reviews.isEmpty else { return 0.0 }
            let totalRating = data.reviews.reduce(0) { $0 + $1.rating }
            return Double(totalRating) / Double(data.reviews.count)
        }
        
        // MARK: - Save Data
        private func saveDataToDisk() {
            let fileURL = getFileURL()
            do {
                let jsonData = try JSONEncoder().encode(self.data)
                try jsonData.write(to: fileURL, options: .atomic)
                print("✅ Successfully saved reviews to disk.")
            } catch {
                print("❌ Failed to save reviews: \(error.localizedDescription)")
            }
        }
        
    }
