//
//  CartViewController.swift
//  ReLeaf
//
//  Created by Ismail Bushehri on 25/12/2024.
//

import UIKit

struct Product: Codable {
    let id: String
    let name: String
    let price: Double
    let stock: Int
    let description: String
    let category: String
    let image: String
}

struct CartItem: Codable {
    let product: Product
    var quantity: Int
}

struct CartData: Codable {
    let products: [Product]
    let cartItems: [CartDataItem]
}

struct CartDataItem: Codable {
    let productId: String
    let quantity: Int
}

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableViewCart: UITableView!
    
    @IBOutlet weak var subtotalViewCartLabel: UILabel!
    
    var products: [Product] = [] 
        var cartItems: [CartItem] = []

        override func viewDidLoad() {
            super.viewDidLoad()

       
            loadLocalData()

           
            tableViewCart.delegate = self
            tableViewCart.dataSource = self

            
            updateTotal()
        }

        func loadLocalData() {
            if let path = Bundle.main.path(forResource: "products", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path))
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(CartData.self, from: data)
                    
                
                    self.products = decodedData.products
                    self.cartItems = decodedData.cartItems.compactMap { dataItem in
                        if let product = products.first(where: { $0.id == dataItem.productId }) {
                            return CartItem(product: product, quantity: dataItem.quantity)
                        }
                        return nil
                    }
                    
                    tableViewCart.reloadData()
                } catch {
                    print("Error loading local data: \(error)")
                }
            }
        }

       
        func updateTotal() {
            let total = cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
            subtotalViewCartLabel.text = "BHD \(String(format: "%.2f", total))"
        }


        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return cartItems.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath)
            let cartItem = cartItems[indexPath.row]
            
            cell.textLabel?.text = cartItem.product.name
            cell.detailTextLabel?.text = "BHD \(cartItem.product.price) x \(cartItem.quantity)"
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                cartItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                updateTotal()
            }
        }
    }

