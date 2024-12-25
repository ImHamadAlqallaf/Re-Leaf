import UIKit

class StoresListTableViewController: UITableViewController {

    @IBOutlet weak var btnStoreAdd: UIBarButtonItem!
    
    // Array to hold stores
    var stores: [Store] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadStoresData()
    }
    
    // Load store data from the localData.json file
    func loadStoresData() {
        // Load the JSON file from the app bundle
        guard let url = Bundle.main.url(forResource: "localData", withExtension: "json") else {
            print("localData.json not found!")
            return
        }
        
        do {
            // Read the data from the JSON file
            let data = try Data(contentsOf: url)
            
            // Decode the JSON data into the stores array
            let decoder = JSONDecoder()
            let storeList = try decoder.decode([String: [Store]].self, from: data)
            
            // Extract the stores array from the decoded dictionary
            if let decodedStores = storeList["stores"] {
                self.stores = decodedStores
            }
            
            // Reload the table view to display the data
            tableView.reloadData()
        } catch {
            print("Error loading or decoding JSON: \(error)")
        }
    }

    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Only one section to display stores
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Number of rows equals the number of stores
        return stores.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath) as! StoresListTableViewCell

        // Get the store for this row
        let store = stores[indexPath.row]

        // Configure the cell
        cell.lblStoreName.text = store.storeName
        
        // Optionally, you can load the first product image or the store's image
        if let productImageName = store.products.first?.image {
            cell.imgProduct.image = UIImage(named: productImageName)  // Assuming local images
        }
        
        return cell
    }

    // MARK: - Actions

    @IBAction func addStoreTapped(_ sender: UIBarButtonItem) {
        // Handle store addition action
    }

    @IBAction func editStoreTapped(_ sender: UIButton) {
        // Handle edit action for a store
    }

    @IBAction func deleteStoreTapped(_ sender: UIButton) {
        // Handle delete action for a store
    }
}
