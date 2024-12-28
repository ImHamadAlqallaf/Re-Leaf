import UIKit

class StoresListTableViewController: UITableViewController, StoresListTableViewCellDelegate {

    @IBOutlet weak var btnStoreAdd: UIBarButtonItem!
    
    var stores: [Store] = []
    var reviews: [Review] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStoresData()
        
        // Set the delegate
        tableView.delegate = self
    }
    
    func getDocumentsDirectory() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first
    }
    
    // Function to load stores data from the JSON file
    func loadStoresData() {
        guard let url = getDocumentsDirectory()?.appendingPathComponent("localData.json") else {
            print("localData.json not found!")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            // Decode JSON data
            let decoder = JSONDecoder()
            let wrapper = try decoder.decode(Wrapper.self, from: data)
            
            self.stores = wrapper.stores
            self.reviews = wrapper.reviews ?? []
            
            // Reload the table view
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Error loading or decoding JSON: \(error)")
        }
    }
    
    // Return the number of sections in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Return the number of rows (stores) in the section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
    // Configure each cell with store data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreCell", for: indexPath) as! StoresListTableViewCell
        let store = stores[indexPath.row]
        
        cell.lblStoreName.text = store.storeName
        
        // Decode the Base64 image if available
        if let image = store.decodedStoreImage() {
            cell.imgProduct.image = image
        } else {
            cell.imgProduct.image = UIImage(systemName: "photo") // Default image if not available
        }
        
        // Set the delegate
        cell.delegate = self
        
        return cell
    }
    
    // Set the height for each row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Action when the Add Store button is tapped
    @IBAction func addStoreTapped(_ sender: UIBarButtonItem) {
        let addingStoreVC = self.storyboard?.instantiateViewController(withIdentifier: "AddingStoreViewController") as! AddingStoreTableViewController
        navigationController?.pushViewController(addingStoreVC, animated: true)
    }

    // Delegate method for edit button tap
    func editButtonTapped(cell: StoresListTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let storeToEdit = stores[indexPath.row]
            
            // Pass the store data to the AddingStore screen
            let addingStoreVC = self.storyboard?.instantiateViewController(withIdentifier: "AddingStoreViewController") as! AddingStoreTableViewController
            addingStoreVC.storeToEdit = storeToEdit // Passing the store data
            
            // Push to the AddingStoreViewController for editing
            navigationController?.pushViewController(addingStoreVC, animated: true)
        }
    }
    
    // Delegate method for delete button tap
    func deleteButtonTapped(cell: StoresListTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let storeToDelete = stores[indexPath.row]
            
            // Show confirmation alert
            let alert = UIAlertController(title: "Delete Store", message: "Are you sure you want to delete this store?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                // Remove the store from the array
                self.stores.remove(at: indexPath.row)
                
                // Reload the table view
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                
                // Save the updated stores array to JSON
                self.saveStoresData()
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
    // Function to save stores data to the JSON file
    func saveStoresData() {
        let wrapper = Wrapper(stores: stores, reviews: reviews)
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(wrapper)
            if let url = getDocumentsDirectory()?.appendingPathComponent("localData.json") {
                try data.write(to: url)
                print("Data saved successfully!")
            }
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    func loadFromJSON(completion: @escaping (Result<Wrapper, Error>) -> Void) {
        do {
            if let url = getDocumentsDirectory()?.appendingPathComponent("localData.json") {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let wrapper = try decoder.decode(Wrapper.self, from: data)
                completion(.success(wrapper))
            } else {
                completion(.failure(NSError(domain: "FileNotFound", code: 404, userInfo: nil)))
            }
        } catch {
            completion(.failure(error))
        }
    }
}
