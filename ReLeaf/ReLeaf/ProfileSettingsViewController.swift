//
//  ProfileSettingsViewController.swift
//  ReLeaf
//
//  Created by Hussain Nader on 28/12/2024.
//

import UIKit

class ProfileSettingsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileSettingImage: UIImageView!
    @IBOutlet weak var profileSettingName: UILabel!
    @IBOutlet weak var profileSettingPhone: UILabel!
    
    @IBOutlet weak var profileSettingsNameTextField: UITextField!
    @IBOutlet weak var profileSettingMobileTextField: UITextField!
    @IBOutlet weak var profileSettingsEmailTextField: UITextField!
    @IBOutlet weak var profileSettingsPasswordsTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureProfileSettings()
        addTapGestureToImage()
    }
    
    private func configureProfileSettings() {
        profileSettingImage.image = UIImage(systemName: "person.circle")
        profileSettingImage.layer.cornerRadius = profileSettingImage.frame.height / 2
        profileSettingImage.clipsToBounds = true
        
        if let user = SessionManager.shared.currentUser {
            profileSettingName.text = user.userName
            profileSettingPhone.text = user.number
            
            profileSettingsNameTextField.text = user.userName
            profileSettingMobileTextField.text = user.number
            profileSettingsEmailTextField.text = user.email
            profileSettingsPasswordsTextField.text = user.password
        }
    }
    
    
    @IBAction func saveProfileChanges(_ sender: UIButton) {
        guard var currentUser = SessionManager.shared.currentUser else {
            showAlert(title: "Error", message: "No user logged in.")
            return
        }
        
        // Update user data
        currentUser.userName = profileSettingsNameTextField.text ?? currentUser.userName
        currentUser.number = profileSettingMobileTextField.text ?? currentUser.number
        currentUser.email = profileSettingsEmailTextField.text ?? currentUser.email
        currentUser.password = profileSettingsPasswordsTextField.text ?? currentUser.password
        
        // Update SessionManager
        SessionManager.shared.currentUser = currentUser
        
        print("Updated User:", currentUser)

                
        // Update in localData.json
        updateUserInLocalJSON(user: currentUser) { [weak self] success in
            if success {
                // Navigate to the next screen using the segue
//                self?.performSegue(withIdentifier: "toAccountSettings", sender: self)
            } else {
                self?.showAlert(title: "Error", message: "Failed to update profile.")
            }
        }
    }
    
    private func updateUserInLocalJSON(user: User, completion: @escaping (Bool) -> Void) {
        do {
            // Step 1: Locate the localData.json file
            guard let url = getDocumentsDirectory()?.appendingPathComponent("localData.json") else {
                print("Error: Could not locate localData.json file.")
                completion(false)
                showAlert(title: "Error", message: "Could not locate data file.")
                return
            }
            
            // Step 2: Load the current data from localData.json
            let data = try Data(contentsOf: url)
            var users = try JSONDecoder().decode([User].self, from: data)
            print("Loaded Users from JSON:", users)
            
            // Step 3: Find and update the current user
            if let index = users.firstIndex(where: { $0.id == user.id }) {
                users[index] = user
            } else {
                print("Error: User not found in localData.json.")
                completion(false)
                showAlert(title: "Error", message: "User not found.")
                return
            }
            
            // Step 4: Encode the updated users array back into JSON
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let updatedData = try encoder.encode(users)
            print("Encoded Updated Users JSON:", String(data: updatedData, encoding: .utf8) ?? "nil")
            
            // Step 5: Save the updated data back to localData.json
            try updatedData.write(to: url)
            print("Updated localData.json successfully.")
            
            completion(true)
        } catch {
            // Step 6: Handle any errors during the process
            print("Error updating localData.json:", error.localizedDescription)
            completion(false)
            showAlert(title: "Error", message: "Failed to update profile: \(error.localizedDescription)")
        }
    }
    
    private func getDocumentsDirectory() -> URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    private func addTapGestureToImage() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileSettingImage.isUserInteractionEnabled = true
        profileSettingImage.addGestureRecognizer(tapGesture)
    }
    
    @objc private func profileImageTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            profileSettingImage.image = selectedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileSettingImage.image = originalImage
        }
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
