//
//  ArticlesManager.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/6/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import Foundation

class ArticlesManager {
    
    static let shared = ArticlesManager()
    var articles = [Article]()

    //MARK: Public methods
    func getArticles(page:Int, successBlock: @escaping SuccesBlock, failureBlock: FailureBlock? = nil) {
        let params: [String: Any] = [
            "show-fields" : "bodyText,thumbnail,headline",
            "page-size" : 20,
            "page" : page
        ]
        APIAdapter.request(method: .get, parameters: params, successBlock: { (data) in
            if page == 1 {
                self.articles.removeAll()
            }
            if let result = try? JSONDecoder().decode(ArticleContainer.self, from: data) {
                self.articles.append(contentsOf: result.results)
            }
            successBlock(data)
        }, failureBlock: failureBlock)
    }
    
    //MARK: - Initialization
    private init() {
    }
}
