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
            // Reload the table view to reflect the loaded data
            tableView.reloadData()
        } else {
            print("Failed to load JSON data.")
        }
    }


    
    // Function to load the JSON file from the app's bundle
    func loadJSONFile(named fileName: String) -> [Shop]? {
        // Get the URL to the JSON file in the app bundle
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") {
            print("File found at: \(fileURL.path)")  // Check the actual path in the console
            do {
                // Read the file data into a Data object
                let data = try Data(contentsOf: fileURL)
                
                // Decode the JSON data into the RootData object
                let decoder = JSONDecoder()
                let rootData = try decoder.decode(RootData.self, from: data)
                
                // Return the shops array
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

    
    

    // MARK: - Table view data source
   

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return shops.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shops[section].products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        
        let shop = shops[indexPath.section]
        let product = shop.products[indexPath.row]
        
        cell.ProductNamelbl.text = product.name
        cell.productPricelbl.text = "$\(product.price)"
        cell.ProductQTYlbl.text = "Stock: \(product.stock)"
        
        
        cell.ProductPictureimg.image = UIImage(named: product.image)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let shop = shops[section]
        return shop.name
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

}
