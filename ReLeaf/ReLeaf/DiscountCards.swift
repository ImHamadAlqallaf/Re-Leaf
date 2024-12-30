import UIKit
import Foundation


struct DiscountCard: Codable {
    let code: String
    let discount: String
    let expiry: String
}

class DiscountCards: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
 
    var discounts: [DiscountCard] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        loadDiscounts()
    }
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardcell", for: indexPath) as! DiscountTableCell
        let discount = discounts[indexPath.row]
        
        
        if let codeLabel = cell.codeLabel,
           let discountLabel = cell.discountLabel,
           let expiryLabel = cell.expiryLabel {
            codeLabel.text = discount.code
            discountLabel.text = "\(discount.discount)%"
            expiryLabel.text = discount.expiry
        } else {
            print("Error: One or more labels are not connected.")
        }
        
        
        cell.deleteAction = { [weak self] in
            self?.deleteDiscount(at: indexPath)
        }
        
        return cell
    }
    
   
    func addDiscount(code: String, discount: String, expiry: String) {
        
        let newDiscount = DiscountCard(code: code, discount: discount, expiry: expiry)
        discounts.append(newDiscount)
        saveDiscounts()
        
        
        DispatchQueue.main.async {
            if let tableView = self.tableView {
                tableView.reloadData()
            } else {
                print("Error: tableView is nil")
            }
        }

    }
    
    func deleteDiscount(at indexPath: IndexPath) {
        discounts.remove(at: indexPath.row)
        
        
        saveDiscounts()
        
       
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
   
    func saveDiscounts() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(discounts)
            
         
            if let url = getFileURL() {
                try data.write(to: url)
            }
        } catch {
            print("Error saving discounts: \(error)")
        }
    }
    
  
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
    
    
    func getFileURL() -> URL? {
        let fileManager = FileManager.default
        do {
            let documentsURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            return documentsURL.appendingPathComponent("discounts.json")  //
        } catch {
            print("Error getting file URL: \(error)")
            return nil
        }
    }
}

