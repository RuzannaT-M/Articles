//
//  Article.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/6/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import Foundation
import RealmSwift

class ArticleContainer: Decodable {
	var results = [Article]()
	
	public required convenience init(from decoder: Decoder) throws {
		self.init()
		let container = try decoder.container(keyedBy: Article.CodingKeys.self).nestedContainer(keyedBy: Article.CodingKeys.self, forKey: .response)
		results = try container.decode(Array<Article>.self, forKey: .results)
	}
}

class Article: Object, Decodable {
    
    @objc dynamic var id: String?
    @objc dynamic var title: String?
    @objc dynamic var content: String?
    @objc dynamic var thumbnail: String?
    @objc dynamic var category: String?
    @objc dynamic var date: Date?
    
    lazy var tags = {
        return Helper.getWordsFromText(title)
    }()
    
    //MARK: - Configurations For DB
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func ignoredProperties() -> [String] {
        return ["tags"]
    }
    
    //MARK: - Initialization		    
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
