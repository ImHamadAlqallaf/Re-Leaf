import UIKit

struct Product: Codable {
    let id: String
    let name: String
    let price: Double
    let image: String
}

struct CartItem: Codable {
    let productId: String
    var quantity: Int
}

//struct Shop: Codable {
//    let id: String
//    let name: String
//    let products: [Product]
//    var cartItems: [CartItem]
//}
//
//struct LocalData: Codable {
//    let shops: [Shop]
//    var cartItems: [CartItem]
//}

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var localData: LocalData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ensure tableView outlet is connected
        guard tableView != nil else {
            fatalError("TableView outlet is not connected")
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Initialize localData to avoid nil
        loadLocalData()
        
        // Ensure localData is not nil
        guard localData != nil else {
            fatalError("localData is not initialized")
        }
    }

    func loadLocalData() {
        // Sample data for testing
        let sampleProducts = [
            Product(id: "product1", name: "Bamboo Toothbrush", price: 3.99, image: "bamboo_toothbrush.png"),
            Product(id: "product2", name: "Reusable Water Bottle", price: 10.99, image: "reusable_bottle.png")
        ]
        
        let sampleCartItems = [
            CartItem(productId: "product1", quantity: 2),
            CartItem(productId: "product2", quantity: 1)
        ]
        
        let sampleShops = [
            Shop(id: "shop1", name: "EcoMart", products: sampleProducts, cartItems: sampleCartItems)
        ]
        
        localData = LocalData(shops: sampleShops, cartItems: sampleCartItems)
        
        // Reload table view data
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localData.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath)
        
        let cartItem = localData.cartItems[indexPath.row]
        let product = getProductById(cartItem.productId)
        
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = "Price: \(product.price) x \(cartItem.quantity)"
        
        return cell
    }
    
    func getProductById(_ id: String) -> Product {
        for shop in localData.shops {
            if let product = shop.products.first(where: { $0.id == id }) {
                return product
            }
        }
        return Product(id: "", name: "Unknown", price: 0.0, image: "")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            localData.cartItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
