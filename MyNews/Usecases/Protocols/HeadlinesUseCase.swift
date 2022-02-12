//
//  GetHeadlines.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation
import Combine

protocol HeadlinesUseCase {
    func search(page: Int, pageSize: Int, searchText: String, country:String ) -> Future<[Article], APICallError>
}
