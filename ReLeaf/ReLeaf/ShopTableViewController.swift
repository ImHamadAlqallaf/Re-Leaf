//
//  StoreManagerTableViewController.swift
//  ReLeaf
//
//  Created by BP-36-201-17 on 25/12/2024.
//

import UIKit

class ShopTableViewController: UITableViewController {

    var shops: [Shop] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the JSON data when the view loads
        if let loadedShops = loadJSONFile(named: "localData") {
            self.shops = loadedShops
            
            print("Loaded Shops: \(self.shops)")
            // Reload the table view to reflect the loaded data
            tableView.reloadData()
        } else {
            print("Failed to load JSON data.")
        }
        
        tableView.rowHeight = 85
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }

    // Function to load the JSON file from the app's bundle
    func loadJSONFile(named fileName: String) -> [Shop]? {
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") {
            print("File found at: \(fileURL.path)")
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let rootData = try decoder.decode(RootData.self, from: data)
                print("Decoded shops: \(rootData.shops)")
                return rootData.shops
            } catch {
                print("Error loading or decoding JSON: \(error)")
                return nil
            }
        } else {
            print("Error: File not found.")
            return nil
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !shops.isEmpty else { return 0 }
        return 3 + shops[0].products.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath)
            cell.textLabel?.text = shops[0].name
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)
            cell.textLabel?.text = """
            Location: \(shops[0].location)
            Owner: \(shops[0].owner)
            Contact: \(shops[0].contact)
            """
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
            cell.textLabel?.text = "Store Products"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
            let productIndex = indexPath.row - 3
            let product = shops[0].products[productIndex]
            
            cell.ProductNamelbl?.text = product.name
            cell.ProductPricelbl?.text = "$\(product.price)"
            cell.ProductQTYlbl?.text = "QTY: \(product.stock)"
            cell.ProductPictureimg?.image = UIImage(named: product.image)
            
            cell.deleteAction = { [weak self] in // ***
                self?.confirmDeleteProduct(at: indexPath) // ***
            }
            
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? { // ***
        let shop = shops[section] // ***
        return shop.name // ***
    } // ***

    func confirmDeleteProduct(at indexPath: IndexPath) { // ***
        let alert = UIAlertController(title: "Delete Product", message: "Are you sure you want to delete this product?", preferredStyle: .alert) // ***
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil)) // ***
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [weak self] _ in // ***
            self?.deleteProduct(at: indexPath) // ***
        })) // ***
        present(alert, animated: true, completion: nil) // ***
    }

    func deleteProduct(at indexPath: IndexPath) { // ***
        shops[0].products.remove(at: indexPath.row - 3) // ***
        tableView.deleteRows(at: [indexPath], with: .automatic) // ***
    }
}
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


