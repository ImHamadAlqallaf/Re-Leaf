import UIKit


struct Product {
    let id: String
    let name: String
    let price: Double
    let stock: Int
    let description: String
    let category: String
    let image: String
}

class SearchPage: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchtableview: UITableView!
    @IBOutlet weak var Searchbar: UISearchBar!
    
    var filteredProducts: [Product] = []
    var products: [Product] = []
    var filterData: [Product] = []
    var searchbarController: UISearchController!
    
    
    var selectedCategory: String?
    var selectedPriceRange: (min: Double, max: Double)?
    
   
    let categories = ["All", "Oral Care", "Drinkware", "Clothing", "Office Supplies"]
    
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
            Product(id: "product2", name: "Reusable Water Bottle", price: 10.99, stock: 30, description: "Stainless steel bottle", category: "Drinkware", image: "reusable_bottle.png"),
            Product(id: "product5", name: "Bamboo Sunglasses", price: 25.99, stock: 100, description: "Stylish bamboo sunglasses", category: "Accessories", image: "bamboo_sunglasses.png")
        ]
        
        let shop2Products = [
            Product(id: "product3", name: "Organic Cotton T-Shirt", price: 15.99, stock: 100, description: "100% organic cotton t-shirt", category: "Clothing", image: "organic_tshirt.png"),
            Product(id: "product4", name: "Wooden Desk Organizer", price: 29.99, stock: 20, description: "Sustainable wooden desk organizer", category: "Office Supplies", image: "wooden_desk_organizer.png"),
            Product(id: "product6", name: "Denim Reusable Jacket", price: 39.99, stock: 50, description: "Eco-friendly denim jacket", category: "Clothing", image: "denim_reusable_jacket.png")
        ]
        
        let shop3Products = [
            Product(id: "product7", name: "Organic Soap Bar", price: 7.99, stock: 120, description: "100% organic soap bar", category: "Personal Care", image: "organic_soap_bar.png"),
            Product(id: "product8", name: "Reusable Coffee Cup", price: 12.50, stock: 75, description: "Eco-friendly reusable coffee cup", category: "Drinkware", image: "reusable_coffee_cup.png"),
            Product(id: "product9", name: "Organic Honey", price: 10.99, stock: 60, description: "Pure organic honey from local farms", category: "Food", image: "organic_honey.png")
        ]
        
        let shop4Products = [
            Product(id: "product10", name: "Solar Phone Charger", price: 25.99, stock: 50, description: "Portable solar phone charger", category: "Electronics", image: "solar_phone_charger.png"),
            Product(id: "product11", name: "Solar Garden Light", price: 15.99, stock: 100, description: "Solar-powered garden light", category: "Outdoor", image: "solar_garden_light.png"),
            Product(id: "product12", name: "Coconut Oil", price: 12.99, stock: 80, description: "Pure organic coconut oil", category: "Health & Beauty", image: "coconut_oil.png")
        ]
        
        
        products = shop1Products + shop2Products + shop3Products + shop4Products
        filterData = products

        
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
    
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        applyFilters(searchText: searchText)
    }
    
    
    @IBAction func Filterbuttontap(_ sender: UIButton) {
        let alert = UIAlertController(title: "Filter Products", message: nil, preferredStyle: .actionSheet)
        
       
        let categoryActionSheet = UIAlertController(title: "Select Category", message: nil, preferredStyle: .alert)
        for category in categories {
            categoryActionSheet.addAction(UIAlertAction(title: category, style: .default, handler: { _ in
                self.selectedCategory = category == "All" ? nil : category
                self.applyFilters(searchText: self.Searchbar.text ?? "")
             }))
        }
        
        
        let priceRangeActionSheet = UIAlertController(title: "Select Price Range", message: nil, preferredStyle: .alert)
        
        let priceRanges: [(min: Double, max: Double, title: String)] = [
            (0, 10, "0 - 10 BD"),
            (10, 20, "10 - 20 BD"),
            (20, 50, "20 - 50 BD"),
            (50, 100, "50 - 100 BD")
        ]
        
        for range in priceRanges {
            priceRangeActionSheet.addAction(UIAlertAction(title: range.title, style: .default, handler: { _ in
                self.selectedPriceRange = (min: range.min, max: range.max)
                self.applyFilters(searchText: self.Searchbar.text ?? "")
            }))
        }
        
        
        alert.addAction(UIAlertAction(title: "Category", style: .default, handler: { _ in
            self.present(categoryActionSheet, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Price Range", style: .default, handler: { _ in
            self.present(priceRangeActionSheet, animated: true, completion: nil)
        }))
        
     
        alert.addAction(UIAlertAction(title: "Clear Filters", style: .destructive, handler: { _ in
            self.selectedCategory = nil
            self.selectedPriceRange = nil
            self.applyFilters(searchText: self.Searchbar.text ?? "")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
   
    func applyFilters(searchText: String) {
        filterData = products.filter { product in
            let matchesSearchText = searchText.isEmpty || product.name.lowercased().contains(searchText.lowercased())
            let matchesCategory = selectedCategory == nil || product.category == selectedCategory
            let matchesPriceRange = selectedPriceRange == nil || (product.price >= selectedPriceRange!.min && product.price <= selectedPriceRange!.max)
            return matchesSearchText && matchesCategory && matchesPriceRange
        }
        searchtableview.reloadData()
    }
}
