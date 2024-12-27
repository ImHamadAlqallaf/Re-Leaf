import UIKit

class AddProductExternallyViewController: UIViewController {

    @IBOutlet weak var txtProductName: UITextField!
    @IBOutlet weak var txtCO2Saved: UITextField!
    @IBOutlet weak var txtPlasticReduced: UITextField!
    @IBOutlet weak var txtWaterSaved: UITextField!
    
    @IBOutlet weak var btnAddproduct: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Any additional setup after loading the view.
    }
    
    @IBAction func btnAddProductTapped(_ sender: UIButton) {
        // 1. Check if all fields are filled
        guard let productName = txtProductName.text, !productName.isEmpty,
              let co2Saved = txtCO2Saved.text, !co2Saved.isEmpty,
              let plasticReduced = txtPlasticReduced.text, !plasticReduced.isEmpty,
              let waterSaved = txtWaterSaved.text, !waterSaved.isEmpty else {
            
            showAlert(message: "All fields must be filled.")
            return
        }

        // 2. Check if the numeric fields contain only numbers
        if !isValidNumber(co2Saved) {
            showAlert(message: "CO2 Saved field must contain numbers only.")
            return
        }
        
        if !isValidNumber(plasticReduced) {
            showAlert(message: "Plastic Reduced field must contain numbers only.")
            return
        }
        
        if !isValidNumber(waterSaved) {
            showAlert(message: "Water Saved field must contain numbers only.")
            return
        }
        
        // If all fields are valid, proceed with storing the data or any other action
        // Here you can save the product, send it to the server, etc.
        print("Product name: \(productName), CO2 saved: \(co2Saved), Plastic reduced: \(plasticReduced), Water saved: \(waterSaved)")
    }
    
    // Helper function to validate if a string is a valid number
    func isValidNumber(_ string: String) -> Bool {
        return Double(string) != nil // Try to convert the string to a Double (numbers only)
    }
    
    // Helper function to show an alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Input Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
