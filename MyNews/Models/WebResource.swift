//
//  WebResource.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation

struct WebResource<T: Codable> {
    let url: URL
    var httpMethod: HttpMethod = .get       //this means the default method will be GET
    var body: Data? = nil
}

extension WebResource {
    init(url: URL){
        self.url = url
    }
}
