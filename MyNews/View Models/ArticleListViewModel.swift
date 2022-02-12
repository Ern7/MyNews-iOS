//
//  ArticleListViewModel.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation
import Combine

class ArticleListViewModel {
    private var articles: [Article]
    
    init(articles: [Article]) {
        self.articles = articles
    }
}

extension ArticleListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
    
    func refreshList(_ articles: [Article]) {
        clearItems()
        self.articles.append(contentsOf: articles)
    }
    
    func addMore(_ articles: [Article]) {
        self.articles.append(contentsOf: articles)
    }
    
    func clearItems() {
        if !self.articles.isEmpty {
            self.articles.removeAll()
        }
    }
    
    func numberOfItems() -> Int {
        return self.articles.count
    }
    
}
