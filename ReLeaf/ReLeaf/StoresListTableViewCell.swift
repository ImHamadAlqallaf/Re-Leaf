import UIKit

class StoresListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var btnStoreEdit: UIButton!
    @IBOutlet weak var btnStoreDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set the content mode to scale the image while preserving its aspect ratio
//        imgProduct.contentMode = .scaleAspectFit
//        imgProduct.clipsToBounds = true  // Ensures that the image is clipped if it doesn't fit perfectly
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
