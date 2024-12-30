import UIKit


struct CartItem: Codable {
    let productId: String
    var quantity: Int

}


class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var subtotalLabel: UILabel!
    
    
    // MARK: - Properties
        var cartItems: [CartItem] = []
        var products: [Product] = []
        
        // MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupTableView()
            loadSampleData()
            updateSubtotal()
        }
        
        // MARK: - Setup TableView
        private func setupTableView() {
            guard tableView != nil else {
                fatalError("TableView outlet is not connected")
            }
            tableView.delegate = self
            tableView.dataSource = self
        }
        
        // MARK: - Load Sample Data
        private func loadSampleData() {
            // Hardcoded Products
                let sampleProducts: [Product] = [
                    Product(
                        id: "product1",
                        name: "Bamboo Toothbrush",
                        price: 3.99,
                        stock: 50,
                        description: "Eco-friendly toothbrush",
                        category: "Oral Care",
                        image: "bamboo_toothbrush.png",
                        badge: "eco_cert.jpg",
                        materials: "100% Bamboo, Recyclable Nylon",
                        co2Emission: "2.5 Kg",
                        waterUsage: "500 L",
                        plasticUsage: "100 g"
                    ),
                    Product(
                        id: "product2",
                        name: "Reusable Water Bottle",
                        price: 10.99,
                        stock: 30,
                        description: "Stainless steel bottle",
                        category: "Drinkware",
                        image: "reusable_bottle.png",
                        badge: "eco_cert.jpg",
                        materials: "Stainless Steel, Reusable lid, Anti-Carbon",
                        co2Emission: "4.5 Kg",
                        waterUsage: "100 L",
                        plasticUsage: "500 g"
                    ),
                    Product(
                        id: "product3",
                        name: "Organic Cotton T-Shirt",
                        price: 15.99,
                        stock: 100,
                        description: "100% organic cotton t-shirt",
                        category: "Clothing",
                        image: "organic_tshirt.png",
                        badge: "eco_cert.jpg",
                        materials: "Made of organic cotton",
                        co2Emission: "1.0 Kg",
                        waterUsage: "150 L",
                        plasticUsage: "500 g"
                    )
            ]
            
            // Hardcoded Cart Items
            cartItems = [
                CartItem(productId: "product1", quantity: 2),
                CartItem(productId: "product2", quantity: 1),
                CartItem(productId: "product3", quantity: 3)
            ]
            
            print("✅ Loaded \(products.count) products into Cart")
            print("✅ Loaded \(cartItems.count) cart items")
            tableView.reloadData()
        }
        
        // MARK: - UITableView DataSource
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return cartItems.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as! CartItemCell
            
            let cartItem = cartItems[indexPath.row]
            let product = getProductById(cartItem.productId)
            
            cell.nameLabel.text = product.name
            cell.priceLabel.text = String(format: "Price: $%.2f", product.price)
            cell.quantityLabel.text = "Quantity: \(cartItem.quantity)"
            cell.productImageView.image = UIImage(named: product.image) ?? UIImage(named: "placeholder")
            
            return cell
        }
        
        // MARK: - Get Product By ID
        private func getProductById(_ id: String) -> Product {
            if let product = products.first(where: { $0.id == id }) {
                return product
            }
            return Product(id: "unknown", name: "Unknown Product", price: 0.0, stock: 0, description: "N/A", category: "N/A", image: "placeholder", badge: "Two", materials: "Zero", co2Emission: "0", waterUsage: "N/A", plasticUsage: "placeholder")
        }
        
        // MARK: - UITableView Editing
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                cartItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                updateSubtotal()
            }
        }
        
        // MARK: - Update Subtotal
        private func updateSubtotal() {
            var subtotal: Double = 0.0
            for cartItem in cartItems {
                let product = getProductById(cartItem.productId)
                subtotal += product.price * Double(cartItem.quantity)
            }
            subtotalLabel.text = String(format: "Subtotal: $%.2f", subtotal)
            print("🛒 Subtotal Updated: $\(subtotal)")
        }
    }
