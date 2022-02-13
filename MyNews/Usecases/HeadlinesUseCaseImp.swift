//
//  HeadlinesImp.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//
// Declaring this class as final so that no other class can inherit from it which means a dev
// cant override this class' methods in order to change behavior.

import Foundation
import Combine

final class HeadlinesUseCaseImp {
    
    static let shared = HeadlinesUseCaseImp()
    
    private func getSearchWebResource(page: Int = 1, pageSize: Int = 20, searchText: String = "", country: String = "za") -> WebResource<NewsApiResponse> {
        
        guard let url = URL(string: "\(Constants.AppConfig.BackendUrl)v2/top-headlines?country=\(country)&apiKey=\(Constants.ApiKeys.NewsApiKey)&pageSize=\(pageSize)&page=\(page)&q=\(searchText)") else {
            fatalError("URL is incorrect!")
        }
        
        return WebResource<NewsApiResponse>(url: url)
    }
}

extension HeadlinesUseCaseImp: HeadlinesUseCase {
    
    func search(page: Int = 1, pageSize: Int = 20, searchText: String = "", country: String = "za") -> Future<[Article], APICallError> {
        return Future { promixe in
            NewsApiService.shared.load(resource: self.getSearchWebResource(page: page, pageSize: pageSize, searchText: searchText, country: country)) { result in
                switch result {
                case .success(let response):
                    promixe(.success(response.articles))
                case .failure(let error):
                    DebuggingLogger.printData(error)
                    promixe(.failure(error))
                }
            }
        }
    }
    
    
}
