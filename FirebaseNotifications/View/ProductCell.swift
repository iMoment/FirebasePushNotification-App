//
//  ProductCell.swift
//  FirebaseNotifications
//
//  Created by Stanley Pan on 21/10/2017.
//  Copyright © 2017 Stanley Pan. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    //  MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configure(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = product.price()
    }
}
