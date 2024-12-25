//
//  ProductCollectionViewCell.swift
//  ReLeaf
//
//  Created by Student on 25/12/2024.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var productmageView: UIImageView!
    @IBOutlet weak var productnameLabel: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            setupUI()
        }
    
    private func setupUI() {
            productImageView.contentMode = .scaleAspectFill
            productImageView.clipsToBounds = true
            productNameLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            productNameLabel.textAlignment = .center
        }
    
    static let identifier = "ProductCell"
        
        private let productImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            return imageView
        }()
        
        private let productNameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            label.textAlignment = .center
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(productImageView)
            contentView.addSubview(productNameLabel)
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupConstraints() {
            productImageView.translatesAutoresizingMaskIntoConstraints = false
            productNameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                productImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                productImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),
                
                productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor),
                productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                productNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
        
        func configure(with product: Product) {
            productImageView.image = UIImage(named: product.image)
            productNameLabel.text = product.name
        }

}
