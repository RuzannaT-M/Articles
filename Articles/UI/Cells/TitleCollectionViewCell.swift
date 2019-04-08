//
//  TitleCollectionViewCell.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/7/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import Foundation
import UIKit

class TitleCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - SuperClass methods
    override func updatedLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes, size: CGSize) -> UICollectionViewLayoutAttributes {
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    //MARK: - Public methods
    func updateCell(title: String?) {
        titleLabel.text = title
    }
}
