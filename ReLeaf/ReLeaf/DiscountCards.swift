import UIKit

class DiscountCards: UIViewController,UITableViewDataSource, UITableViewDelegate {
   


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    // This will hold all the discounts added
    var discounts: [(code: String, discount: String, expiry: String)] = []
    
    var codetext = String()
    var discounttext = String()
    var expirytext = String()
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardcell", for: indexPath) as! DiscountTableCell
        let discount = discounts[indexPath.row]

        // Safely unwrapping the labels
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

    // Function to delete a discount
    func deleteDiscount(at indexPath: IndexPath) {
        discounts.remove(at: indexPath.row) // Remove from the array
        tableView.deleteRows(at: [indexPath], with: .automatic) // Update the table view
    }
    
    func addDiscount(code: String, discount: String, expiry: String) {
        // Append the new coupon to the array
        discounts.append((code, discount, expiry))
        
        // Reload the table view
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }


}
