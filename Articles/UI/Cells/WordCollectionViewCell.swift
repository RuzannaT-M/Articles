//
//  WordCollectionViewCell.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/7/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import Foundation
import UIKit

class WordCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - SuperClass methods
    override func updatedLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes, size: CGSize) -> UICollectionViewLayoutAttributes {
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height) + 5
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    //MARK: - Public methods
    func updateCell(word: String, count: Int) {
        titleLabel.text = ""
        wordLabel.text = "\(word) (\(count))"
    }
    
    func updateCell(text: String) {
        titleLabel.text = text
        wordLabel.text = ""
    }
}
