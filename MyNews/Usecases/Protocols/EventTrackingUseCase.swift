//
//  EventTrackingUseCase.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/13.
//

import Foundation

protocol EventTrackingUseCase {
    func logArticleViewed(articleTitle: String)
    func logArticleViewedInBrowser(articleTitle: String, articleUrl: String)
    func logCountryChangedTo(country: String)
}
