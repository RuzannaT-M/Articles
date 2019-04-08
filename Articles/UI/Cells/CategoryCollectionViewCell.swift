//
//  CategoryCollectionViewCell.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/7/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import Foundation
import UIKit

class CategoryCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var imageVIew: UIImageView!
    
    //MARK: - SuperClass methods
    override func updatedLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes, size: CGSize) -> UICollectionViewLayoutAttributes {
        let height:CGFloat = 40
        layoutAttributes.frame.size.height = height
        UIHelper.roundCorners(view: imageVIew, radius: height/2)
        return layoutAttributes
    }

    //MARK: - Public methods
    func updateCell(article: Article?) {
        timeLabel.text = UIHelper.getHoursFromDate(date: article?.date)
        categoryLabel.text = article?.category
        if let imageUrl = article?.thumbnail {
            let url = URL(string: imageUrl)
            imageVIew.kf.setImage(with: url)
        }
    }
}
