//
//  CategoryDetailCollectionViewCell.swift
//  PayGyftTest
//
//  Created by Purushottam on 25/08/19.
//  Copyright © 2019 Oodles. All rights reserved.
//

import UIKit

class CategoryDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        logoImageView.layer.cornerRadius = logoImageView.frame.size.height/2
        // Initialization code
    }

}
