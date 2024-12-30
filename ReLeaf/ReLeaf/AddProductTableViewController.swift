//
//  AddProductTableViewController.swift
//  ReLeaf
//
//  Created by BP-36-201-17 on 26/12/2024.
//


import UIKit

protocol AddProductDelegate: AnyObject {
    func didAddProduct(_ product: Product)
}

class AddProductTableViewController: UITableViewController {
    
    weak var delegate: AddProductDelegate?
    
    // Outlets
    @IBOutlet weak var ProductPicimg: UIImageView!
    @IBOutlet weak var AddPhotobtn: UIButton!
    @IBOutlet weak var ProductNamelbl: UILabel!
    @IBOutlet weak var ProductNametxt: UITextField!
    @IBOutlet weak var ProductDesclbl: UILabel!
    @IBOutlet weak var ProductDesctxt: UITextField!
    @IBOutlet weak var ProductPricelbl: UILabel!
    @IBOutlet weak var ProductPricetxt: UITextField!
    @IBOutlet weak var ProductBadgelbl: UILabel!
    @IBOutlet weak var ProductBadgetxt: UITextField!
    @IBOutlet weak var ProductStocklbl: UILabel!
    @IBOutlet weak var ProductStocktxt: UITextField!
    @IBOutlet weak var Categorylbl: UILabel!
    @IBOutlet weak var Categorytxt: UITextField!
    @IBOutlet weak var Materialslbl: UILabel!
    @IBOutlet weak var Materialstxt: UITextField!
    @IBOutlet weak var CO2lbl: UILabel!
    @IBOutlet weak var CO2txt: UITextField!
    @IBOutlet weak var Waterlbl: UILabel!
    @IBOutlet weak var Watertxt: UITextField!
    @IBOutlet weak var Plasticlbl: UILabel!
    @IBOutlet weak var Plastictxt: UITextField!
    @IBOutlet weak var AddProductbtn: UIBarButtonItem!

    // Save Product Action
    @IBAction func saveProduct(_ sender: UIBarButtonItem) {
        guard let name = ProductNametxt.text, !name.isEmpty else {
               print("Validation Failed: Product Name is empty.")
               showAlert(message: "Product Name cannot be empty")
               return
           }
           print("Product Name: \(name)")
           
           guard let description = ProductDesctxt.text, !description.isEmpty else {
               print("Validation Failed: Product Description is empty.")
               showAlert(message: "Product Description cannot be empty")
               return
           }
           print("Product Description: \(description)")
           
           guard let priceText = ProductPricetxt.text, let price = Double(priceText) else {
               print("Validation Failed: Invalid or empty Product Price.")
               showAlert(message: "Invalid or empty Product Price")
               return
           }
           print("Product Price: \(price)")
           
           guard let badge = ProductBadgetxt.text, !badge.isEmpty else {
               print("Validation Failed: Badge is empty.")
               showAlert(message: "Badge cannot be empty")
               return
           }
           print("Product Badge: \(badge)")
           
           guard let stockText = ProductStocktxt.text, let stock = Int(stockText) else {
               print("Validation Failed: Invalid or empty Product Stock.")
               showAlert(message: "Invalid or empty Product Stock")
               return
           }
           print("Product Stock: \(stock)")
           
           guard let category = Categorytxt.text, !category.isEmpty else {
               print("Validation Failed: Category is empty.")
               showAlert(message: "Category must be either Food&Drinks, OuterWear, Hygiene or BodyCare")
               return
           }
           print("Product Category: \(category)")
           
           guard let materials = Materialstxt.text, !materials.isEmpty else {
               print("Validation Failed: Materials are empty.")
               showAlert(message: "Materials cannot be empty")
               return
           }
           print("Product Materials: \(materials)")
           
           guard let co2 = CO2txt.text, !co2.isEmpty else {
               print("Validation Failed: CO2 Emission is empty.")
               showAlert(message: "CO2 Emission cannot be empty")
               return
           }
           print("CO2 Emission: \(co2)")
           
           guard let water = Watertxt.text, !water.isEmpty else {
               print("Validation Failed: Water Usage is empty.")
               showAlert(message: "Water Usage cannot be empty")
               return
           }
           print("Water Usage: \(water)")
           
           guard let plastic = Plastictxt.text, !plastic.isEmpty else {
               print("Validation Failed: Plastic Usage is empty.")
               showAlert(message: "Plastic Usage cannot be empty")
               return
           }
           print("Plastic Usage: \(plastic)")


        let newProduct = Product(
            id: UUID().uuidString,
            name: name,
            price: price,
            stock: stock,
            description: description,
            category: category,
            image: "default_image.png",
            badge: badge,
            materials: materials,
            co2Emission: co2,
            waterUsage: water,
            plasticUsage: plastic
        )

        // Pass the product back via delegate
        print("Passing product to delegate: \(newProduct)")
        delegate?.didAddProduct(newProduct)
        
        let successAlert = UIAlertController(title: "Success", message: "The product has been added successfully!", preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                // Dismiss the view controller after alert
                self.navigationController?.popViewController(animated: true)
            }))
            present(successAlert, animated: true, completion: nil)

        // Dismiss the view controller
        navigationController?.popViewController(animated: true)
    }

    // Helper Function to Show Alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
               // Additional setup if needed
    }

    // MARK: - Table view data source

   
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


