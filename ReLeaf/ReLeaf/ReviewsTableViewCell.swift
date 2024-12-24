//
//  ReviewsTableViewCell.swift
//  ReLeaf
//
//  Created by BP-needchange on 15/12/2024.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {


    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var reviewTextLabel: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    
    func configure(with review: Review) {
            userNameLabel.text = review.userName
            reviewTextLabel.text = review.text
            updateStarRating(to: review.rating)
        }

        private func updateStarRating(to rating: Int) {
            let starImages = [star1, star2, star3, star4, star5]

            for (index, imageView) in starImages.enumerated() {
                if index < rating {
                    imageView?.image = UIImage(systemName: "star.fill") // Filled Star
                } else {
                    imageView?.image = UIImage(systemName: "star") // Empty Star
                }
            }
        }

}
