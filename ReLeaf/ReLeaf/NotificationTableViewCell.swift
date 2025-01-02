//
//  NotificationTableViewCell.swift
//  ReLeaf
//
//  Created by BP-36-224-15 on 28/12/2024.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var notificationlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 1
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            // Add padding to the cell
            let padding: CGFloat = 10
            contentView.frame =
            contentView.frame.inset(by: UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
    
    }

