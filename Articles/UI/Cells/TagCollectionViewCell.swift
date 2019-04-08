//
//  TagCollectionViewCell.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/7/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import Foundation
import UIKit

class TagCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var tagLabel: UILabel!
    
    //MARK: - SuperClass methods
    override func updatedLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes, size: CGSize) -> UICollectionViewLayoutAttributes {
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height + 5)
        frame.size.width = ceil(size.width + 20)
        layoutAttributes.frame = frame
        UIHelper.roundCorners(view: self, radius: ceil(frame.height)/2)
        return layoutAttributes
    }
        
    //MARK: - Public methods
    func updateCell(tag: String?) {
        tagLabel.text = tag
    }
}
