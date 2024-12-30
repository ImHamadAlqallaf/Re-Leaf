import UIKit

class AddingStoreTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
    // MARK: - Properties
    var storeToEdit: Store? // Optional property to hold the store data for editing
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If we're editing an existing store, populate the fields
        if let store = storeToEdit {
            txtStoreName.text = store.storeName
            txtStoreEmail.text = store.storeEmail
            txtStorePhoneNumber.text = store.storePhoneNumber
            txtStoreDescription.text = store.storeDescription
            txtStoreOwner.text = store.storeOwner
            if let image = store.decodedStoreImage() {
                imgStorePhoto.image = image
            }
            
            // Change the button text to "Update Store" and "Update Photo"
            btnAddStore.title = "Update Store"
            btnAddPhoto.setTitle("Update Photo", for: .normal)
            
            // Set the navigation title to "Updating Store"
            self.title = "Updating Store"
        } else {
            // If no store to edit, show default values
            btnAddStore.title = "Add Store"
            btnAddPhoto.setTitle("Add Photo", for: .normal)
            
            // Set the navigation title to "Adding Store"
            self.title = "Adding Store"
        }
    }
    
    // MARK: - Add/Update Store Action
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

        guard let password = txtStorePassword.text, !password.isEmpty else {
            showAlert(message: "Please enter a password.")
            return
        }

        guard !password.contains(" ") else {
            showAlert(message: "Password must not contain spaces.")
            return
        }

        // MARK: - Prepare Store Object
        let storeImageBase64 = imgStorePhoto.image?.pngData()?.base64EncodedString()

        // Use existing store ID if editing, else generate a new one
        let newStoreId = storeToEdit?.id ?? UUID().uuidString

        let newStore = Store(
            id: newStoreId,
            storeName: storeName,
            storeEmail: email,
            storePassword: password,
            storePhoneNumber: phone,
            storeDescription: description,
            storeOwner: owner,
            storeImage: storeImageBase64,
            products: []
        )

        // MARK: - Load Existing Data and Save
        loadFromJSON { [weak self] result in
            guard let self = self else { return }

            var wrapper = Wrapper(stores: []) // Default wrapper if file doesn't exist

            switch result {
            case .success(var existingWrapper):
                wrapper = existingWrapper // Use loaded data
            case .failure:
                print("No existing data found, creating new data file.")
            }

            // Update or append the store
            if let storeIndex = wrapper.stores.firstIndex(where: { $0.id == newStore.id }) {
                // Update the existing store
                wrapper.stores[storeIndex] = newStore
            } else {
                // Add the new store
                wrapper.stores.append(newStore)
            }

            self.saveToJSON(wrapper: wrapper) { success in
                DispatchQueue.main.async {
                    if success {
                        print("Store updated successfully!")
                        
                        // Pop the current view controller (returning to the stores list view)
                        self.navigationController?.popViewController(animated: true)
                        
                        // Notify the previous view controller (StoresListTableViewController) to reload
                        if let storesListVC = self.navigationController?.viewControllers.first(where: { $0 is StoresListTableViewController }) as? StoresListTableViewController {
                            storesListVC.loadStoresData() // Reload the stores list
                        }
                    } else {
                        self.showAlert(message: "Failed to update store.")
                    }
                }
            }
        }
    }

    // MARK: - Add Photo Action
    @IBAction func addPhotoTapped(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imgStorePhoto.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Helper Functions
    
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
    
    func getDocumentsDirectory() -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first
    }

    typealias JSONCompletionHandler = (Result<Wrapper, Error>) -> Void

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
}
