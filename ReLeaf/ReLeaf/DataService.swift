//
//  DataService.swift
//  ReLeaf
//
//  Created by BP-36-201-17 on 25/12/2024.
//

import Foundation

class DataService {
    
    // Function to load shops from a local JSON file
    func loadShops() -> [Shop]? {
        // Get the path to the JSON file in the app's bundle
        guard let url = Bundle.main.url(forResource: "shops", withExtension: "json") else {
            print("Failed to find JSON file")
            return nil
        }
        
        do {
            // Load data from the file
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            // Decode the data into an array of Shop objects
            let shops = try decoder.decode([Shop].self, from: data)
            return shops
        } catch {
            print("Failed to decode JSON: \(error)")
            return nil
        }
    }
    
    
}
