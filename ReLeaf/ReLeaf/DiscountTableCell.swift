import UIKit

class DiscountTableCell: UITableViewCell {

    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var discountLabel: UILabel!
    
    @IBOutlet weak var expiryLabel: UILabel!
    
    
    var deleteAction: (() -> Void)?
    
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        deleteAction?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}

