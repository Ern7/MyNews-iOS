//
//  EventTrackingUseCaseImp.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/13.
//

import Foundation
import FirebaseAnalytics

final class EventTrackingUseCaseImp {
    static let shared = EventTrackingUseCaseImp()
}

extension EventTrackingUseCaseImp: EventTrackingUseCase {

    func logArticleViewed(articleTitle: String) {
            FirebaseAnalytics.Analytics.logEvent(Constants.CustomFirebaseEvents.ArticleDetailScreenViewed, parameters: [
              AnalyticsParameterScreenName: "article_detail_view",
              Constants.CustomFirebaseEventsParameterKeys.ArticleTitle: articleTitle
            ])
    }
    
    func logArticleViewedInBrowser(articleTitle: String, articleUrl: String) {
            FirebaseAnalytics.Analytics.logEvent(Constants.CustomFirebaseEvents.ViewedArticleInBrowser, parameters: [
              AnalyticsParameterScreenName: "article_detail_view",
              Constants.CustomFirebaseEventsParameterKeys.ArticleTitle: articleTitle,
              Constants.CustomFirebaseEventsParameterKeys.ArticleURL: articleUrl
            ])
    }
    
    func logCountryChangedTo(country: String) {
        FirebaseAnalytics.Analytics.logEvent(Constants.CustomFirebaseEvents.ChangedCountry, parameters: [
              AnalyticsParameterScreenName: "countries_view_controller",
              Constants.CustomFirebaseEventsParameterKeys.CountryChangedToKey: country
            ])
    }
    
}
