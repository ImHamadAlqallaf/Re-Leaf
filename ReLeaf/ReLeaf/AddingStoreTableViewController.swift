import UIKit

class AddingStoreTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var btnAddStore: UIBarButtonItem!
    @IBOutlet weak var imgStorePhoto: UIImageView!
    @IBOutlet weak var btnAddPhoto: UIButton!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var txtStoreName: UITextField!
    @IBOutlet weak var lblStoreEmail: UILabel!
    @IBOutlet weak var txtStoreEmail: UITextField!
    @IBOutlet weak var lblStorePassword: UILabel!
    @IBOutlet weak var txtStorePassword: UITextField!
    @IBOutlet weak var lblStorePhoneNumber: UILabel!
    @IBOutlet weak var txtStorePhoneNumber: UITextField!
    @IBOutlet weak var lblStoreDescription: UILabel!
    @IBOutlet weak var txtStoreDescription: UITextField!
    @IBOutlet weak var lblStoreOwner: UILabel!
    @IBOutlet weak var txtStoreOwner: UITextField!
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup initial UI elements
        imgStorePhoto.contentMode = .scaleAspectFit
        imgStorePhoto.image = UIImage(systemName: "person.circle") // Default image
    }
    
    // MARK: - Add Store Action
    @IBAction func addStoreTapped(_ sender: UIBarButtonItem) {
        // MARK: - Validation
        guard let storeName = txtStoreName.text, !storeName.isEmpty else {
            showAlert(message: "Please enter a store name.")
            return
        }

        guard let email = txtStoreEmail.text, !email.isEmpty, email.contains("@releaf.com") else {
            showAlert(message: "Please enter a valid email address with '@releaf.com'.")
            return
        }

        guard let phone = txtStorePhoneNumber.text, !phone.isEmpty, isValidPhoneNumber(phone) else {
            showAlert(message: "Please enter a valid phone number (numeric, 8 digits).")
            return
        }

        guard let description = txtStoreDescription.text, !description.isEmpty else {
            showAlert(message: "Please enter a store description.")
            return
        }

        guard let owner = txtStoreOwner.text, !owner.isEmpty else {
            showAlert(message: "Please enter the store owner's name.")
            return
        }

        // MARK: - Prepare Store Object
        let newStoreId = UUID().uuidString // Unique ID
        let storeImageBase64: String? = imgStorePhoto.image?.pngData()?.base64EncodedString()

        let newStore = Store(
            id: newStoreId,
            storeName: storeName,
            storeEmail: email,
            storePassword: txtStorePassword.text ?? "",
            storePhoneNumber: phone,
            storeDescription: description,
            storeOwner: owner,
            storeImage: storeImageBase64,
            products: []
        )

        // MARK: - Load Existing Data and Save
        loadFromJSON { [weak self] result in
            guard let self = self else { return }
            
            var wrapper = Wrapper(stores: [], reviews: nil) // Default wrapper if file doesn't exist

            switch result {
            case .success(var existingWrapper):
                wrapper = existingWrapper // Use loaded data
            case .failure:
                print("No existing data found, creating new data file.")
            }

            // Append the new store and save
            wrapper.stores.append(newStore)
            self.saveToJSON(wrapper: wrapper) { success in
                DispatchQueue.main.async {
                    if success {
                        print("Store added successfully!")
                        
                        // Pop the current view controller (returning to the stores list view)
                        self.navigationController?.popViewController(animated: true)
                        
                        // Notify the previous view controller (StoresListTableViewController) to reload
                        if let storesListVC = self.navigationController?.viewControllers.first(where: { $0 is StoresListTableViewController }) as? StoresListTableViewController {
                            storesListVC.loadStoresData()
                        }
                    } else {
                        self.showAlert(message: "Failed to save store.")
                    }
                }
            }
        }
    }



    // MARK: - Helper Functions
    
    func getNextStoreId() -> String {
        var highestId = 0
        
        if let url = getDocumentsDirectory()?.appendingPathComponent("localData.json") {
            do {
                let wrapper = try loadData(from: url)
                
                for store in wrapper.stores {
                    if let id = Int(store.id) {
                        highestId = max(highestId, id)
                    }
                }
            } catch {
                print("Error reading JSON: \(error)")
            }
        }
        
        return String(highestId + 1)
    }
    
    func loadData(from url: URL) throws -> Wrapper {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let wrapper = try decoder.decode(Wrapper.self, from: data)
        return wrapper
    }
    
    func saveData(_ wrapper: Wrapper, to url: URL) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let encodedData = try encoder.encode(wrapper)
        try encodedData.write(to: url)
    }
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = "^[0-9]{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    typealias JSONCompletionHandler = (Result<Wrapper, Error>) -> Void
    
    func saveToJSON(wrapper: Wrapper, completion: @escaping (Bool) -> Void) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(wrapper)
            if let url = getDocumentsDirectory()?.appendingPathComponent("localData.json") {
                try data.write(to: url)
                completion(true)
            } else {
                completion(false)
            }
        } catch {
            print("Error saving data: \(error)")
            completion(false)
        }
    }

    func loadFromJSON(completion: @escaping JSONCompletionHandler) {
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

    func getDocumentsDirectory() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first
    }
    

}
