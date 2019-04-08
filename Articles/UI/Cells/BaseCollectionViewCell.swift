//
//  BaseCollectionViewCell.swift
//  Articles
//
//  Created by Artavazd Barseghyan on 4/7/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import Foundation
import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    //MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        return updatedLayoutAttributes(layoutAttributes: layoutAttributes, size: size)
    }
    
    func updatedLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes, size: CGSize) -> UICollectionViewLayoutAttributes {
        return layoutAttributes
    }
}
