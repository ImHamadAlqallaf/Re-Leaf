import UIKit

class ProductImpactTrackerViewController: UIViewController {

    @IBOutlet weak var btnNextProduct: UIButton!
    @IBOutlet weak var btnPreviousProduct: UIButton!
    
    @IBOutlet weak var lblCO2Saved: UILabel!
    @IBOutlet weak var lblPlasticReduced: UILabel!
    @IBOutlet weak var lblWaterConserved: UILabel!
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    
    // Define a Product struct to hold the product data
    struct Product {
        var name: String
        var imageName: String
        var co2Saved: String
        var plasticReduced: String
        var waterConserved: String
    }
    
    // Create an array of products
    var products: [Product] = [
        Product(name: "Eco Bottle", imageName: "eco_bottle_image", co2Saved: "10kg", plasticReduced: "5kg", waterConserved: "200L"),
        Product(name: "Green Shirt", imageName: "green_shirt_image", co2Saved: "5kg", plasticReduced: "1kg", waterConserved: "100L"),
        Product(name: "Reusable Bag", imageName: "reusable_bag_image", co2Saved: "2kg", plasticReduced: "0.5kg", waterConserved: "50L"),
        // Add more products as needed
    ]
    
    // Keep track of the current product index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateProductView()
    }
    
    // Method to update the UI based on the current product
    func updateProductView() {
        // Get the current product from the products array
        let product = products[currentIndex]
        
        // Update the UI elements
        lblProductName.text = product.name
        imgProduct.image = UIImage(named: product.imageName)
        lblCO2Saved.text = "CO2 Saved: \(product.co2Saved)"
        lblPlasticReduced.text = "Plastic Reduced: \(product.plasticReduced)"
        lblWaterConserved.text = "Water Conserved: \(product.waterConserved)"
    }
    
    // Action for Next Product button
    @IBAction func nextProductTapped(_ sender: UIButton) {
        // Increment currentIndex to move to the next product
        if currentIndex < products.count - 1 {
            currentIndex += 1
        } else {
            // Optionally, loop back to the first product
            currentIndex = 0
        }
        updateProductView()
    }
    
    // Action for Previous Product button
    @IBAction func previousProductTapped(_ sender: UIButton) {
        // Decrement currentIndex to move to the previous product
        if currentIndex > 0 {
            currentIndex -= 1
        } else {
            // Optionally, loop back to the last product
            currentIndex = products.count - 1
        }
        updateProductView()
    }
}
