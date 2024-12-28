//
//  CustomFlowLayout.swift
//  ReLeaf
//
//  Created by BP-36-201-23 on 27/12/2024.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {

    override init() {
            super.init()
            setupLayout()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupLayout()
        }
        
        func setupLayout() {
            minimumInteritemSpacing = 10
            minimumLineSpacing = 10
            scrollDirection = .horizontal
            itemSize = CGSize(width: 150, height: 200) // Adjust the size as needed
        }
}
