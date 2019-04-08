//
//  Article.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/6/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import Foundation
import UIKit

class ArticleContainer: Decodable {
	var results = [Article]()
	
	public required convenience init(from decoder: Decoder) throws {
		self.init()
		let container = try decoder.container(keyedBy: Article.CodingKeys.self).nestedContainer(keyedBy: Article.CodingKeys.self, forKey: .response)
		results = try container.decode(Array<Article>.self, forKey: .results)
	}
}

class Article: Decodable {
    
    var id: String?
    var title: String?
    var content: String?
    var thumbnail: String?
    var category: String?
    var date: Date?
    var tags = [String]()
    
    //MARK: - Initialization
    init() {}
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: Article.CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        category = try values.decodeIfPresent(String.self, forKey: .sectionName)
        let fields = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .fields)
        title = try fields.decodeIfPresent(String.self, forKey: .headline)
        thumbnail = try fields.decodeIfPresent(String.self, forKey: .thumbnail)
        content = try fields.decodeIfPresent(String.self, forKey: .bodyText)
        if let dateStr = try values.decodeIfPresent(String.self, forKey: .webPublicationDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            date = dateFormatter.date(from: dateStr)
        }
        tags = Helper.getWordsFromText(title)
    }
}

extension Article {
	enum CodingKeys: String, CodingKey {
		case response
		case results
		case id
		case sectionName
		case fields
		case headline
		case thumbnail
		case bodyText
		case webPublicationDate
	}
}
