//
//  ArticleViewController.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/6/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import UIKit

enum SectionType : Int {
    case title = 0
    case tags = 1
    case content = 2
    case words = 3
    case category = 4
}

class ArticleViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    var article: Article?
    let itemsInset: CGFloat = 5
    var wordsDict = [String : Int]()
    var selectedWordIndexPath: IndexPath?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        wordsDict = UIHelper.generateWordToCountMapping(text: article?.content ?? "")
        updateCollectionView(width: self.view.frame.width)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateCollectionView(width: size.width)
    }
    
    //MARK: - Private methods
    private func updateCollectionView(width: CGFloat) {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = width*widthConstraint.multiplier
            flowLayout.estimatedItemSize = CGSize.init(width: Int(width), height: 1)
        }
        collectionView.reloadData()
    }
    
    //MARK: Update cells
    private func updateTitleCell(indexPath: IndexPath) -> TitleCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleCollectionViewCell", for: indexPath) as! TitleCollectionViewCell
        cell.updateCell(title: article?.title)
        return cell
    }
    
    private func updateTagCell(indexPath: IndexPath) -> TagCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath) as! TagCollectionViewCell
        cell.updateCell(tag: article?.tags[indexPath.row])
        return cell
    }
    
    private func updateContentCell(indexPath: IndexPath) -> ContentCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as! ContentCollectionViewCell
        var word:String?
        if let indexPath = selectedWordIndexPath {
            let keys = Array(wordsDict.keys)
            word = keys[indexPath.row-1]
        }
        cell.updateCell(content: article?.content, selectedWord: word)
        return cell
    }
    
    private func updateWordsCell(indexPath: IndexPath) -> WordCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WordCollectionViewCell", for: indexPath) as! WordCollectionViewCell
        if indexPath.row == 0 {
            cell.updateCell(text: "Top word count:")
        } else {
            let key = Array(wordsDict.keys)[indexPath.row-1]
            let count = wordsDict[key] ?? 0
            cell.updateCell(word: key, count: count)
        }
        return cell
    }
    
    private func udpateCategoryCell(indexPath: IndexPath) -> CategoryCollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.updateCell(article: article)
        return cell
    }
}

extension ArticleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case SectionType.title.rawValue,
             SectionType.content.rawValue,
             SectionType.category.rawValue:
            return 1
        case SectionType.tags.rawValue:
            return article?.tags.count ?? 0
        case SectionType.words.rawValue:
            return wordsDict.count != 0 ? wordsDict.count + 1 : 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return updateTitleCell(indexPath: indexPath)
        case 1:
            return updateTagCell(indexPath: indexPath)
        case 2:
            return updateContentCell(indexPath: indexPath)
        case 3:
            return updateWordsCell(indexPath: indexPath)
        case 4:
            return udpateCategoryCell(indexPath: indexPath)
        default:
            return UICollectionViewCell.init()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 3 && indexPath.row != 0 {
            selectedWordIndexPath = indexPath
            if let cell = collectionView.cellForItem(at: IndexPath.init(row: 0, section:
                SectionType.content.rawValue)) as? ContentCollectionViewCell {
                let keys = Array(wordsDict.keys)
                cell.highLightWordInContent(keys[indexPath.row-1])
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemsInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return section == 3 ? 0 : itemsInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: itemsInset, left: 0, bottom: itemsInset, right: 0)
    }
}
