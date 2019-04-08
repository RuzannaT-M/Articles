//
//  ArticlesListViewController.swift
//  Articles
//
//  Created by Ruzanna Ter-Martirosyan on 4/6/19.
//  Copyright © 2019 Ruzanna Ter-Martirosyan. All rights reserved.
//

import UIKit

class ArticlesListViewController: UIViewController {
    
    @IBOutlet weak var articlesTableView: UITableView!

    private let loader = UIActivityIndicatorView(style: .gray)
    private let refreshControl = UIRefreshControl()

    var articles = [Article]()
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
        ArticlesManager.shared.getArticles(page: currentPage, successBlock: {_ in
            if self.currentPage == 1 {
                self.articles.removeAll()
            }
            self.currentPage += 1
            self.updateUI()
        })
    }
    
    @objc private func refreshArticles() {
        self.currentPage = 1
        self.fetchNewArticles()
    }
    
    private func updateUI() {
        self.articles = ArticlesManager.shared.articles
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
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath)
            as! ArticleTableViewCell
        cell.updateCell(article: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == articles.count - 3 {
            fetchNewArticles()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        let vc:ArticleViewController = UIStoryboard.instantiateController()
        vc.article = article
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
