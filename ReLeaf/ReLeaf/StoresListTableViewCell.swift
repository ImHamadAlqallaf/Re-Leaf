import UIKit

protocol StoresListTableViewCellDelegate: AnyObject {
    func editButtonTapped(cell: StoresListTableViewCell)
    func deleteButtonTapped(cell: StoresListTableViewCell)
}

class StoresListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var btnStoreEdit: UIButton!
    @IBOutlet weak var btnStoreDelete: UIButton!
    
    weak var delegate: StoresListTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnStoreEdit.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        btnStoreDelete.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }

    @objc func editButtonTapped() {
        delegate?.editButtonTapped(cell: self)
    }

    @objc func deleteButtonTapped() {
        delegate?.deleteButtonTapped(cell: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
