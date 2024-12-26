import UIKit

class StoresListTableViewController: UITableViewController {

    @IBOutlet weak var btnStoreAdd: UIBarButtonItem!
    
    var stores: [Store] = []
    var reviews: [Review] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStoresData()
    }
    
    func getDocumentsDirectory() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first
    }
    
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
            tableView.reloadData()
        } catch {
            print("Error loading or decoding JSON: \(error)")
        }
    }

    
    

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stores.count
    }
    
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
        
        return cell
    }
    
    @IBAction func addStoreTapped(_ sender: UIBarButtonItem) {
        let addingStoreVC = self.storyboard?.instantiateViewController(withIdentifier: "AddingStoreViewController") as! AddingStoreTableViewController
        navigationController?.pushViewController(addingStoreVC, animated: true)
    }

    @IBAction func editStoreTapped(_ sender: UIButton) {
        print("Edit store tapped")
    }

    @IBAction func deleteStoreTapped(_ sender: UIButton) {
        print("Delete store tapped")
    }
}
