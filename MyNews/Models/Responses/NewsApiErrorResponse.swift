//
//  NewsApiErrorResponse.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation

struct NewsApiErrorResponse: Codable {
    let status, code, message: String
}
