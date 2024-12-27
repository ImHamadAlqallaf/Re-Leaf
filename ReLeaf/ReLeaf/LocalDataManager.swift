//
//  JSONManager.swift
//  ReLeaf
//
//  Created by Hussain Nader on 25/12/2024.
//

import Foundation

class LocalDataManager {
    static let shared = LocalDataManager()
        private init() {}
        
        private let fileManager = FileManager.default
        private var documentsURL: URL {
            fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
        private var fileURL: URL {
            documentsURL.appendingPathComponent("localData.json")
        }
        
    func debugFileExistence() {
        if fileManager.fileExists(atPath: fileURL.path) {
            print("✅ localData.json exists at: \(fileURL.path)")
            do {
                let jsonData = try Data(contentsOf: fileURL)
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("📄 localData.json contents:\n\(jsonString)")
                } else {
                    print("⚠️ localData.json exists but is empty or not readable.")
                }
            } catch {
                print("❌ Error reading localData.json: \(error.localizedDescription)")
            }
        } else {
            print("❌ localData.json does not exist in Documents Directory.")
        }
    }

    
        // MARK: - Copy Initial JSON If Missing
    func copyInitialJSONIfNeeded(force: Bool = false) {
        if force || !fileManager.fileExists(atPath: fileURL.path) {
            print("📂 Copying localData.json from Bundle to Documents Directory...")
            if let bundleURL = Bundle.main.url(forResource: "localData", withExtension: "json") {
                do {
                    if fileManager.fileExists(atPath: fileURL.path) {
                        try fileManager.removeItem(at: fileURL)
                    }
                    try fileManager.copyItem(at: bundleURL, to: fileURL)
                    print("✅ Successfully copied localData.json from Bundle.")
                } catch {
                    print("❌ Error copying localData.json: \(error.localizedDescription)")
                }
            } else {
                print("❌ Could not find localData.json in Bundle.")
            }
        } else {
            print("✅ localData.json already exists in Documents Directory.")
        }
    }

        
        // MARK: - Load Local Data
    
    func debugDecodeLocalData() {
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let localData = try decoder.decode(LocalData.self, from: jsonData)
            print("✅ Successfully decoded localData.json")
        } catch DecodingError.keyNotFound(let key, let context) {
            print("❌ Key '\(key)' not found: \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            print("❌ Type mismatch for type \(type): \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            print("❌ Value not found for type \(type): \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(let context) {
            print("❌ Data corrupted: \(context.debugDescription)")
        } catch {
            print("❌ Unknown decoding error: \(error.localizedDescription)")
        }
    }
    
        func loadLocalData() -> LocalData? {
            do {
                let jsonData = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let localData = try decoder.decode(LocalData.self, from: jsonData)
                return localData
            } catch {
                print("❌ Error loading localData.json: \(error.localizedDescription)")
                return nil
            }
        }
        
        // MARK: - Save Local Data
        func saveLocalData(_ localData: LocalData) {
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                encoder.dateEncodingStrategy = .iso8601
                let jsonData = try encoder.encode(localData)
                try jsonData.write(to: fileURL)
                print("✅ Successfully saved localData.json to Documents Directory.")
            } catch {
                print("❌ Error saving localData.json: \(error.localizedDescription)")
            }
        }
    
        
        // MARK: - Debug Method
//    func debugDecodeLocalData() {
//        do {
//            let jsonData = try Data(contentsOf: fileURL)
//            let decoder = JSONDecoder()
//            decoder.dateDecodingStrategy = .iso8601
//            let localData = try decoder.decode(LocalData.self, from: jsonData)
//            print("✅ Successfully decoded localData.json: \(localData)")
//        } catch {
//            print("❌ Decoding Error: \(error.localizedDescription)")
//        }
//    }

}
