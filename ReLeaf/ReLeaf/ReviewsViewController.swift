//
//  ReviewsViewController.swift
//  ReLeaf
//
//  Created by BP-needchange on 15/12/2024.
//

import UIKit


class ReviewsViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var averageStarsStackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    var reviews: [Review] = []
       
       override func viewDidLoad() {
           super.viewDidLoad()
           tableView.delegate = self
           tableView.dataSource = self
           loadReviews()
       }
       
       // MARK: - Load Reviews
       func loadReviews() {
           reviews = LocalDataService.shared.getReviews()
               print("📊 Reviews Loaded: \(reviews.count)")  // Check if the reviews are loaded correctly
               updateAverageRating()
               tableView.reloadData()
       }
       
       // MARK: - Update Average Rating
       func updateAverageRating() {
           let averageRating = LocalDataService.shared.calculateAverageRating()
           averageRatingLabel.text = String(format: "%.1f", averageRating)
           updateStars(for: averageRating)
       }
       
       func updateStars(for rating: Double) {
           let starImageViews = averageStarsStackView.arrangedSubviews.compactMap { $0 as? UIImageView }
           for (index, imageView) in starImageViews.enumerated() {
               if Double(index + 1) <= rating {
                   imageView.image = UIImage(systemName: "star.fill")
               } else if Double(index) < rating {
                   imageView.image = UIImage(systemName: "star.lefthalf.fill")
               } else {
                   imageView.image = UIImage(systemName: "star")
               }
           }
       }
       
       // MARK: - UITableView DataSource
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return reviews.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewsTableViewCell
           let review = reviews[indexPath.row]
           cell.configure(with: review)
           return cell
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WriteReviewSegue" {
            if let writeReviewVC = segue.destination as? WriteReviewViewController {
                writeReviewVC.delegate = self
                print("🟢 Delegate set to ReviewsViewController in prepare(for:sender:)")
            }
        }
    }
   }

   // MARK: - WriteReviewDelegate
   extension ReviewsViewController: WriteReviewDelegate {
       func didSubmitReview(_ review: Review) {
           print("🟢 Delegate method didSubmitReview triggered")
           //LocalDataService.shared.addReview(review) // Add the review to local storage
               // Reload the reviews and update the table view
               loadReviews()  // This reloads the reviews and updates the UI

           tableView.reloadData()
                  print("✅ Table view reloaded with new review")
           }
   }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */

    


