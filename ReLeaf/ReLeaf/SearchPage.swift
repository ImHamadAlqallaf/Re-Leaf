import UIKit


class SearchPage: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchtableview: UITableView!
    @IBOutlet weak var Searchbar: UISearchBar!
    
    // MARK: - Properties
    var filteredProducts: [Product] = []
    var products: [Product] = []
    var filterData: [Product] = []
    var searchbarController: UISearchController!
    
    var selectedCategory: String?
    var selectedPriceRange: (min: Double, max: Double)?
    
    let categories = ["All", "Oral Care", "Drinkware", "Clothing", "Office Supplies", "Accessories"]
    
    // MARK: - Lifecycle
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
    
    // MARK: - Load Data
    func loadData() {
        let shop1Products = [
            Product(id: "product1", name: "Bamboo Toothbrush", price: 3.99, stock: 50, description: "Eco-friendly toothbrush", category: "Oral Care", image: "bamboo_toothbrush.png", badge: "eco_cert.jpg", materials: "100% Bamboo, Recyclable Nylon", co2Emission: "2.5 Kg", waterUsage: "500 L", plasticUsage: "100 g"),
            Product(id: "product2", name: "Reusable Water Bottle", price: 10.99, stock: 30, description: "Stainless steel bottle", category: "Drinkware", image: "reusable_bottle.png", badge: "eco_cert.jpg", materials: "Stainless Steel, Reusable lid, Anti-Carbon", co2Emission: "4.5 Kg", waterUsage: "100 L", plasticUsage: "500 g"),
            Product(id: "product5", name: "Bamboo Sunglasses", price: 25.99, stock: 100, description: "Stylish bamboo sunglasses", category: "Accessories", image: "bamboo_sunglasses.png", badge: "eco_cert.jpg", materials: "100% Bamboo", co2Emission: "1.5 Kg", waterUsage: "200 L", plasticUsage: "50 g")
        ]
        
        let shop2Products = [
            Product(id: "product3", name: "Organic Cotton T-Shirt", price: 15.99, stock: 100, description: "100% organic cotton t-shirt", category: "Clothing", image: "organic_tshirt.png", badge: "eco_cert.jpg", materials: "Made of organic cotton", co2Emission: "1.0 Kg", waterUsage: "150 L", plasticUsage: "500 g"),
            Product(id: "product4", name: "Wooden Desk Organizer", price: 29.99, stock: 20, description: "Sustainable wooden desk organizer", category: "Office Supplies", image: "wooden_desk_organizer.png", badge: "eco_cert.jpg", materials: "Sustainable Wood", co2Emission: "2.0 Kg", waterUsage: "10 L", plasticUsage: "90 g")
        ]
        
        let shop3Products = [
            Product(id: "product7", name: "Reusable Shopping Bag", price: 1.99, stock: 150, description: "Durable and reusable shopping bag", category: "Kitchen Items", image: "reusable_bag.jpeg", badge: "eco_cert.jpg", materials: "Recycled Plastic", co2Emission: "0.5 Kg", waterUsage: "20 L", plasticUsage: "10 g"),
            Product(id: "product8", name: "Solar Powered Lantern", price: 15.99, stock: 40, description: "Lantern powered by solar energy", category: "Outdoor", image: "solar_lantern.jpeg", badge: "eco_cert.jpg", materials: "Plastic, Solar Panel", co2Emission: "5.0 Kg", waterUsage: "0 L", plasticUsage: "0 g")
        ]
        
        let shop4Products = [
            Product(id: "product10", name: "Gentle Gum Toothbrush", price: 4.99, stock: 80, description: "Gum-friendly, easy-to-use toothbrush", category: "Oral Care", image: "toothbrush.jpeg", badge: "eco_cert.jpg", materials: "Gentle Plastic", co2Emission: "1.2 Kg", waterUsage: "30 L", plasticUsage: "20 g"),
            Product(id: "product11", name: "Eco-friendly Shampoo", price: 6.99, stock: 70, description: "Shampoo with natural ingredients", category: "Personal Care", image: "eco_shampoo.jpeg", badge: "eco_cert.jpg", materials: "Natural Ingredients", co2Emission: "1.8 Kg", waterUsage: "40 L", plasticUsage: "25 g")
        ]
        
        products = shop1Products + shop2Products + shop3Products + shop4Products
        filterData = products
        
        searchtableview.reloadData()
        print("✅ Loaded \(products.count) products into Search Page")
    }
    
    //        // MARK: - Setup Methods
    //        private func setupSearchBar() {
    //            searchbarController = UISearchController(searchResultsController: nil)
    //            searchbarController.searchBar.delegate = self
    //            searchbarController.searchBar.placeholder = "Search products..."
    //            searchbarController.obscuresBackgroundDuringPresentation = false
    //            self.Searchbar.delegate = self
    //        }
    //
    //        private func setupTableView() {
    //            searchtableview.delegate = self
    //            searchtableview.dataSource = self
    //        }
    //
    //        // MARK: - Filtering Logic
    //        func applyFilters(searchText: String) {
    //            filterData = products.filter { product in
    //                let matchesSearchText = searchText.isEmpty || product.name.lowercased().contains(searchText.lowercased())
    //                let matchesCategory = selectedCategory == nil || product.category == selectedCategory
    //                let matchesPriceRange = selectedPriceRange == nil || (product.price >= selectedPriceRange!.min && product.price <= selectedPriceRange!.max)
    //                return matchesSearchText && matchesCategory && matchesPriceRange
    //            }
    //            searchtableview.reloadData()
    //        }
    //
    //        @IBAction func Filterbuttontap(_ sender: UIButton) {
    //            selectedCategory = nil
    //            selectedPriceRange = nil
    //            applyFilters(searchText: Searchbar.text ?? "")
    //        }
    //    }
    //
    //    // MARK: - TableView Methods
    //    extension SearchPage {
    //        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //            return filterData.count
    //        }
    //
    //        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchPageTableViewCell
    //            let product = filterData[indexPath.row]
    //            cell.ProductImage.image = UIImage(named: product.image)
    //            cell.Label1.text = product.name
    //            cell.Label2.text = "\(product.price) BD"
    //            return cell
    //        }
    //
    //        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //            let selectedProduct = filterData[indexPath.row]
    //            let storyboard = UIStoryboard(name: "Search Page", bundle: nil)
    //            guard let productInfoVC = storyboard.instantiateViewController(withIdentifier: "ProductInfoViewController") as? ProductinfoViewController else { return }
    //            productInfoVC.selectedProduct = selectedProduct
    //            navigationController?.pushViewController(productInfoVC, animated: true)
    //        }
    //    }
    //
    //    // MARK: - SearchBar Delegate
    //    extension SearchPage {
    //        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //            applyFilters(searchText: searchText)
    //        }
    //
    //
    //}
    
    
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
