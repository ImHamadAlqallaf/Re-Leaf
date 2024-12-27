//
//  WriteReviewViewController.swift
//  ReLeaf
//
//  Created by Student on 14/12/2024.
//

import UIKit


protocol WriteReviewDelegate: AnyObject {
    func didSubmitReview(_ review: Review)
}

class WriteReviewViewController: UIViewController {
    
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var star1: UIButton!
    @IBOutlet weak var star2: UIButton!
    @IBOutlet weak var star3: UIButton!
    @IBOutlet weak var star4: UIButton!
    @IBOutlet weak var star5: UIButton!
    @IBOutlet weak var opaqueView: UIView!
    @IBOutlet weak var thankYouPopupView: UIView!
    
    
    weak var delegate: WriteReviewDelegate?
    var selectedRating: Int = 0
    
    // Add the productID property
    var productID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        opaqueView.isHidden = true
        thankYouPopupView.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: Star Rating Logic
    
    @IBAction func starTapped(_ sender: UIButton) {
        
        switch sender {
        case star1:
            updateStarRating(to: 1)
        case star2:
            updateStarRating(to: 2)
        case star3:
            updateStarRating(to: 3)
        case star4:
            updateStarRating(to: 4)
        case star5:
            updateStarRating(to: 5)
        default:
            break
        }
    }
    
    private func updateStarRating(to rating: Int) {
        selectedRating = rating
        let starButtons = [star1, star2, star3, star4, star5]
        
        for (index, button) in starButtons.enumerated() {
            if index < rating {
                button?.setImage(UIImage(systemName: "star.fill"), for: .normal) //Filled Star
            } else {
                button?.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
        
    }
    
    
    
    // MARK: - Submit Review
    @IBAction func submitReviewTapped(_ sender: UIButton) {
        
        // Ensure that productID is available
            guard let productID = self.productID else {
                showAlert(message: "Product ID is missing.")
                return
            }
        
        // Validate Text Review
          guard let text = reviewTextView.text, !text.isEmpty else {
              showAlert(message: "Please enter your review.")
              return
          }

          // Validate star rating
          guard selectedRating > 0 else {
              showAlert(message: "Please select a star rating.")
              return
          }

          // Confirm Submission Alert
          let alert = UIAlertController(title: "Confirm Submission", message: "Are you sure you want to submit your review?", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
          alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
              self.submitReview()
          }))
          
          present(alert, animated: true, completion: nil)
      }

      // MARK: - Submit Review Logic (After Confirmation)
      private func submitReview() {
          // Create a new Review object
          let newReview = Review(
              id: UUID().uuidString,
              userName: "Test User",
              productID: productID, // Use the passed productID here
              text: reviewTextView.text ?? "",
              rating: selectedRating,
              timestamp: Date()
          )

          // Add review locally and notify delegate
          ReviewLocalDataService.shared.addReview(newReview)
          print("✅ Review successfully added locally")
          delegate?.didSubmitReview(newReview)
          print("🟢 Delegate notified about new review")
          showThankYouPopup()
      }
    
    // MARK: - Thank You Popup
        private func showThankYouPopup() {
            opaqueView.isHidden = false
            thankYouPopupView.isHidden = false
        }

        @IBAction func thankYouContinueTapped(_ sender: UIButton) {
            opaqueView.isHidden = true
            thankYouPopupView.isHidden = true
            navigationController?.popViewController(animated: true)
        }
    
    // MARK: - Alert Helper
        private func showAlert(message: String, completion: (() -> Void)? = nil) {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                completion?()
            })
            present(alert, animated: true)
        }
    }

    // MARK: - UITextViewDelegate
        extension WriteReviewViewController: UITextViewDelegate {
            func textViewDidBeginEditing(_ textView: UITextView) {
                if textView.text == "Write your review here..." {
                    textView.text = ""
                    textView.textColor = .black
                }
            }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write your review here..."
            textView.textColor = .lightGray
        }
    }
}

    

    
    /*
     // MARK: - Navigation
     
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier ==
                // Get the new view controller using segue.destination.
                // Pass the selected object to the new view controller.
    }
     */
    


