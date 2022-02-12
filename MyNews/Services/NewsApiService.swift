//
//  NewsApiService.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation

class NewsApiService {
    static let shared = NewsApiService()
    
    func load<T>(resource: WebResource<T>, completion: @escaping (Result<T, APICallError>) -> Void){
        
        if !DeviceNetworkMonitor.shared.isDeviceConnectedToInternet {
            completion(.failure(APICallError(message: "It seems like you don't have a working internet connection.", kind: .internetConnectionError)))
            return
        }
        
        var request = URLRequest(url: resource.url)
        request.httpMethod = resource.httpMethod.rawValue
        request.httpBody = resource.body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                //completion(.failure(.domainError))
                //throw APICallError(message: NetworkError.domainError.localizedDescription, kind: .domainError)
                completion(.failure(APICallError(message: "A domain error has occurred. Please make sure your URL is correct.", kind: .domainError)))
                return
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            }
            else {
                
                let errorResponseResult = try? JSONDecoder().decode(NewsApiErrorResponse.self, from: data)
                if let errorResponseResult = errorResponseResult {
                    DispatchQueue.main.async {
                        completion(.failure(APICallError(message: errorResponseResult.message, kind: .serverError)))
                    }
                }
                else {
                    completion(.failure(APICallError(message: "Failed to decode API call response.", kind: .decodingError)))
                }
            }
        }.resume()
    }
    
}
