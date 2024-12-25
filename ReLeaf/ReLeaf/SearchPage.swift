import UIKit

class SearchPage: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    @IBOutlet weak var searchtableview: UITableView!
    @IBOutlet weak var Searchbar: UISearchBar!
    
    
    var products: [Product] = []
    var filterData: [Product] = []
    var searchbarController: UISearchController!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        loadData()

        
        searchbarController = UISearchController(searchResultsController: nil)
        searchbarController.searchBar.delegate = self
        searchbarController.searchBar.placeholder = "Search here..."
        searchbarController.obscuresBackgroundDuringPresentation = false
        self.Searchbar.delegate = self
        self.searchtableview.delegate = self
        self.searchtableview.dataSource = self
    }

   
    func loadData() {
        
        let shop1Products = [
            Product(id: "product1", name: "Bamboo Toothbrush", price: 3.99, stock: 50, description: "Eco-friendly toothbrush", category: "Oral Care", image: "bamboo_toothbrush.png"),
            Product(id: "product2", name: "Reusable Water Bottle", price: 10.99, stock: 30, description: "Stainless steel bottle", category: "Drinkware", image: "reusable_bottle.png")
        ]
        
        let shop2Products = [
            Product(id: "product3", name: "Organic Cotton T-Shirt", price: 15.99, stock: 100, description: "100% organic cotton t-shirt", category: "Clothing", image: "organic_tshirt.png"),
            Product(id: "product4", name: "Wooden Desk Organizer", price: 29.99, stock: 20, description: "Sustainable wooden desk organizer", category: "Office Supplies", image: "wooden_desk_organizer.png")
        ]
        
        
        products = shop1Products + shop2Products
        filterData = products

        // Reload the table view
        searchtableview.reloadData()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchPageTableViewCell
        
        
        let product = filterData[indexPath.row]
        
        
        cell.ProductImage.image = UIImage(named: product.image)
        cell.Label1.text = product.name
        cell.Label2.text = "\(product.price) BD"
        
        return cell
    }

    // MARK: - UISearchBar Delegate Methods
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            filterData = products
        } else {
            filterData = products.filter { product in
                product.name.lowercased().contains(searchText.lowercased())
            }
        }
        
       
        searchtableview.reloadData()
    }
}


struct Product {
    let id: String
    let name: String
    let price: Double
    let stock: Int
    let description: String
    let category: String
    let image: String
}



