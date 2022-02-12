//
//  ArticleViewModel.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation

struct ArticleViewModel {
    private let article: Article
    private let dateFormatter = DateFormatter()
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    
    var sourceName: String {
        return self.article.source.name
    }
    
    var author: String {
        if let _author = self.article.author {
            return _author
        }
        return ""
    }
    
    var title: String {
        return self.article.title
    }
    
    var description: String {
        if let _description = self.article.articleDescription {
            return _description
        }
        return "Description unavailable"
    }
    
    var url: String {
        return self.article.url
    }
    
    var urlToImage: String {
        if let _urlToImage = self.article.urlToImage {
            return _urlToImage
        }
        return ""
    }
    
    var publishedAt: String {
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        let datePublished = dateFormatter.date(from: self.article.publishedAt)
          
     //   dateFormatter.dateFormat = "dd MMM, yyyy"
     //   let friendlyDate = dateFormatter.string(from: datePublished!)
        return datePublished!.timeAgoDisplay()
    }
    
    var content: String {
        if let _content = self.article.content {
            return _content
        }
        return "Content unavailable"
    }
    
    var subtitle: String {
        var _subtitle = self.author
        
        if !_subtitle.isEmpty {
            _subtitle = "\(_subtitle) ∙ "
        }
        
        _subtitle = "\(_subtitle)\(self.publishedAt)"
        return _subtitle
    }
}
