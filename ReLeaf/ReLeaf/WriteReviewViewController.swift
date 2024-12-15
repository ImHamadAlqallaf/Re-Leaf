//
//  WriteReviewViewController.swift
//  ReLeaf
//
//  Created by Student on 14/12/2024.
//

import UIKit
import FirebaseFirestore


protocol WriteReviewDelegate: AnyObject {
    func didSubmitReview(_ review: Review)
}

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewTextLabel: UILabel!

    func configure(with review: Review) {
        reviewTextLabel.text = review.text
    }
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
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        opaqueView.isHidden = true
        thankYouPopupView.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: Star Rating Logic
    @IBAction func starTapped(_ sender: UIButton){
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
//        // CCheck if the review text is empty
//        guard let reviewText = reviewTextView.text, !reviewText.trimmingCharacters(in: .whitespaces).isEmpty else {
//            // show alert when the text is empty
//            let alert = UIAlertController(title: "Invalid Input", message: "Please write somrthing in the review before submitiing", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            return
//        }
//        
//        // Proceed to confirmation Alert
//        showConfirmationAlert(reviewText: reviewText)
        
        guard let text = reviewTextView.text, !text.isEmpty else {
                    showAlert(message: "Please enter your review.")
                    return
                }
                guard selectedRating > 0 else {
                    showAlert(message: "Please select a star rating.")
                    return
                }

                let newReview = Review(
                    id: UUID().uuidString,
                    userName: "Test User", // Replace with actual username from Firebase Auth later
                    text: text,
                    rating: selectedRating,
                    timestamp: Date()
                )

                do {
                    try db.collection("reviews").document(newReview.id).setData(from: newReview)
                    showAlert(message: "Review submitted successfully!") {
                        self.navigationController?.popViewController(animated: true)
                    }
                } catch {
                    print("Error saving review: \(error.localizedDescription)")
                }
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

    
//    func showConfirmationAlert(reviewText: String) {
//        // Create an alert to confirm submission
//        let alert = UIAlertController(title: "Submit Review",message: "Are you sure you want to submit this review?",preferredStyle: .alert)
//        
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        
//        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak self] action in
//            // Show the thank you popup when the review is submitted
//            self?.saveReviewAndShowPopup(reviewText: reviewText)
//        }))
//        
//        self.present(alert, animated: true, completion: nil)
//    }
    
//    func saveReviewAndShowPopup(reviewText: String) {
//        let rating = Int(ratingSlider.value.rounded())
//        let newReview = Review(text: reviewText, rating: rating)
//        delegate?.didSubmitReview(newReview)
//        showThankYouPopup()
//    }
//    
//    @IBAction func continueButtonTapped(_ sender: UIButton) {
//        hideThankYouPopup()  // Hide the popup and overlay
//        navigationController?.popViewController(animated: true)
//    }
//    
//    func showThankYouPopup() {
//        opaqueView.isHidden = false
//        thankYouPopupView.isHidden = false
//    }
//    
//    func hideThankYouPopup() {
//        opaqueView.isHidden = true
//        thankYouPopupView.isHidden = true
//    }
    
    
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
    


