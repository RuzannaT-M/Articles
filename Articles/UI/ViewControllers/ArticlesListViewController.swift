//
//  ArticlesListViewController.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/6/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import UIKit
import RealmSwift

class ArticlesListViewController: UIViewController {
    
    @IBOutlet weak var articlesTableView: UITableView!

    private let loader = UIActivityIndicatorView(style: .gray)
    private let refreshControl = UIRefreshControl()

    var articles: Results<Article>?
    var currentPage: Int = 1
    let cellHeight:CGFloat = 200
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        articlesTableView.tableFooterView = loader
        articlesTableView.estimatedRowHeight = cellHeight
        articlesTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshArticles), for: .valueChanged)
        fetchNewArticles()
    }
    
    //MARK: - Private methods
    private func fetchNewArticles() {
        loader.startAnimating()
        articlesTableView.tableFooterView?.isHidden = false
        ArticlesManager.shared.getArticles(page: currentPage, successBlock: { result, error  in
            if let error = error {
                UIHelper.showAlert(with: error.localizedDescription, from: self)
                return
            }
            if self.articles == nil {
                self.articles = result
            }
            self.currentPage += 1
            self.updateUI()
        }, failureBlock: { error in
            UIHelper.showAlert(with: error, from: self)
        })
    }
    
    @objc private func refreshArticles() {
        self.currentPage = 1
        self.fetchNewArticles()
    }
    
    private func updateUI() {
        self.stopAnimations()
        self.articlesTableView.reloadData()
    }
    
    private func stopAnimations() {
        self.refreshControl.endRefreshing()
        self.loader.stopAnimating()
        self.articlesTableView.tableFooterView?.isHidden = true
    }
}

extension ArticlesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath)
            as! ArticleTableViewCell
        cell.updateCell(article: articles?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let article = articles?[indexPath.row] {
            let vc:ArticleViewController = UIStoryboard.instantiateController()
            vc.article = article
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ArticlesListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let last = indexPaths.last else { return }
        if let count = articles?.count, last.row == count - 3 {
            fetchNewArticles()
        }
    }
}
