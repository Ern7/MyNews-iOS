//
//  NewsApiResponse.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation

struct NewsApiResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
