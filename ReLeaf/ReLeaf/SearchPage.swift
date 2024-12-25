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
            Product(id: "product2", name: "Reusable Water Bottle", price: 10.99, stock: 30, description: "Stainless steel bottle", category: "Drinkware", image: "reusable_bottle.png")
        ]
        
        let shop2Products = [
            Product(id: "product3", name: "Organic Cotton T-Shirt", price: 15.99, stock: 100, description: "100% organic cotton t-shirt", category: "Clothing", image: "organic_tshirt.png"),
            Product(id: "product4", name: "Wooden Desk Organizer", price: 29.99, stock: 20, description: "Sustainable wooden desk organizer", category: "Office Supplies", image: "wooden_desk_organizer.png")
        ]
        
        products = shop1Products + shop2Products
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
