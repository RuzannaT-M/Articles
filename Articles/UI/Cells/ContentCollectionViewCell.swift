//
//  ContentCollectionViewCell.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/7/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import Foundation
import UIKit

class ContentCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var contentTextView: UITextView!
    
    //MARK: - SuperClass methods
    override func updatedLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes, size: CGSize) -> UICollectionViewLayoutAttributes {
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    //MARK: - Public methods
    func updateCell(content: String?, selectedWord: String?) {
        if let word = selectedWord {
            highLightWordInContent(word)
        } else {
            contentTextView.text = content
        }
    }
    
    func highLightWordInContent(_ word: String) {
        if let content = contentTextView.text {
            let font = UIFont.init(name: "HelveticaNeue-Light", size: 15) ?? UIFont.systemFont(ofSize: 15)
            let attributed = NSMutableAttributedString.init(string: content, attributes: [NSAttributedString.Key.font : font])
            let searchPattern = "\\b" + NSRegularExpression.escapedPattern(for: word) + "\\b"
            let regex = try! NSRegularExpression(pattern: searchPattern, options: .caseInsensitive)
            let range = NSRange(location: 0, length: content.count)
            for match in regex.matches(in: content.folding(options: .caseInsensitive, locale: .current), options: .withoutAnchoringBounds, range: range) {
                attributed.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.yellow, range: match.range)
            }
            contentTextView?.attributedText = attributed
        }
    }
}
