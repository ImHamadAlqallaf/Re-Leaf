//
//  WriteReviewViewController.swift
//  ReLeaf
//
//  Created by Student on 14/12/2024.
//

import UIKit

class WriteReviewViewController: UIViewController {

    @IBAction func submitReviewTapped(_ sender: UIButton) {
        // Create an alert to confirm submission
                  let alert = UIAlertController(title: "Submit Review",message: "Are you sure you want to submit this review?",preferredStyle: .alert)

                  alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

                  alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { action in
                      // Show the thank you popup when the review is submitted
                      self.thankYouPopupView.isHidden = false
                  }))

                  self.present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var opaqueView: UIView!
    
    @IBOutlet weak var thankYouPopupView: UIView!
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        hideThankYouPopup()  // Hide the popup and overlay
        navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        opaqueView.isHidden = true
        thankYouPopupView.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    func showThankYouPopup() {
            opaqueView.isHidden = false
            thankYouPopupView.isHidden = false
        }

        func hideThankYouPopup() {
            opaqueView.isHidden = true
            thankYouPopupView.isHidden = true
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
