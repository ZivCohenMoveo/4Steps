//
//  CollectionViewCell.swift
//  Signup
//
//  Created by Ziv Cohen on 28/10/2018.
//  Copyright © 2018 Moveo. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initCell(_ view: UIView, backgroundColor: UIColor) {
        self.addSubview(view)
        view.backgroundColor = backgroundColor
        self.bringSubviewToFront(view)
        view.frame = self.bounds
    }

}
