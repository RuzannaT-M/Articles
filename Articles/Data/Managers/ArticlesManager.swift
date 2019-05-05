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
    private let dbAdapter = DataBaseAdapter()
    private var isInFetchingProcess = false

    //MARK: Public methods
    func getArticles(page:Int, successBlock: @escaping DBSuccesBlock, failureBlock: FailureBlock? = nil) {
        if isInFetchingProcess {
            return
        }
        dbAdapter.getObjects { result, error  in
            successBlock(result, error)
        }
        isInFetchingProcess = true
        let params: [String: Any] = [
            "show-fields" : "bodyText,thumbnail,headline",
            "page-size" : 20,
            "page" : page
        ]
        APIAdapter.request(method: .get, parameters: params, successBlock: { (data) in
            var articles = [Article]()
            if let result = try? JSONDecoder().decode(ArticleContainer.self, from: data) {
                articles.append(contentsOf: result.results)
            }
            self.dbAdapter.saveObjects(objects: articles)
            self.isInFetchingProcess = false
        }, failureBlock: { error in
            self.isInFetchingProcess = false
            failureBlock?(error)
        })
    }
    
    //MARK: - Initialization
    private init() {
    }
}
