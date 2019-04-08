//
//  ArticleTableViewCell.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/6/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Public methods
    func updateCell(article: Article) {
        titleLabel.text = article.title
        UIHelper.roundCorners(view: articleImageView, radius: 5)
        UIHelper.roundCorners(view: titleLabel, radius: 5)
        if let imageUrl = article.thumbnail {
            let url = URL(string: imageUrl)
            articleImageView.kf.setImage(with: url)
        } else {
            articleImageView.image = nil
        }
    }
}
