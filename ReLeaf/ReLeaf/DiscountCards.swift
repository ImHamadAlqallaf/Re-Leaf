import UIKit
import Foundation

// DiscountCard model that will be saved to and loaded from a JSON file
struct DiscountCard: Codable {
    let code: String
    let discount: String
    let expiry: String
}

class DiscountCards: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // This will hold all the discount cards
    var discounts: [DiscountCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Load the existing discounts from the local file when the view loads
        loadDiscounts()
    }
    
    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardcell", for: indexPath) as! DiscountTableCell
        let discount = discounts[indexPath.row]
        
        // Safely unwrapping the labels to update the discount information in the cell
        if let codeLabel = cell.codeLabel,
           let discountLabel = cell.discountLabel,
           let expiryLabel = cell.expiryLabel {
            codeLabel.text = discount.code
            discountLabel.text = "\(discount.discount)%"
            expiryLabel.text = discount.expiry
        } else {
            print("Error: One or more labels are not connected.")
        }
        
        // Set the delete action for the delete button
        cell.deleteAction = { [weak self] in
            self?.deleteDiscount(at: indexPath)
        }
        
        return cell
    }
    
    // MARK: - Adding and Deleting Discount
    
    func addDiscount(code: String, discount: String, expiry: String) {
        // Create a new DiscountCard
        let newDiscount = DiscountCard(code: code, discount: discount, expiry: expiry)
        discounts.append(newDiscount)  // Add the new discount to the array
        
        // Save the updated discounts array to the file
        saveDiscounts()
        
        // Reload the table view to reflect the new discount
        DispatchQueue.main.async {
            if let tableView = self.tableView {
                tableView.reloadData()
            } else {
                print("Error: tableView is nil")
            }
        }

    }
    
    func deleteDiscount(at indexPath: IndexPath) {
        discounts.remove(at: indexPath.row)  // Remove the discount from the array
        
        // Save the updated discounts array to the file after deletion
        saveDiscounts()
        
        // Update the table view after deletion
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Saving and Loading Data
    
    // Save the current discounts to a local file (in JSON format)
    func saveDiscounts() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(discounts)
            
            // Get the file URL where we will save the data
            if let url = getFileURL() {
                try data.write(to: url)
            }
        } catch {
            print("Error saving discounts: \(error)")
        }
    }
    
    // Load the discounts from the local file (in JSON format)
    func loadDiscounts() {
        do {
            if let url = getFileURL() {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                discounts = try decoder.decode([DiscountCard].self, from: data)
            }
        } catch {
            print("Error loading discounts: \(error)")
        }
    }
    
    // Helper function to get the file URL where the data will be saved
    func getFileURL() -> URL? {
        let fileManager = FileManager.default
        do {
            let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            return documentsURL.appendingPathComponent("discounts.json")  // The file will be named "discounts.json"
        } catch {
            print("Error getting file URL: \(error)")
            return nil
        }
    }
}

