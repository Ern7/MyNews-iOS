//
//  LocalDataService.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation

class LocalDataService {
    static let shared = LocalDataService()
    
    func fetchCountries(completion: @escaping (Result<[Country], APICallError>) -> Void) {
        var countries = [Country]()
        for localeCode in NSLocale.isoCountryCodes {
            let identifier = NSLocale(localeIdentifier: localeCode)
            let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            countries.append(Country(code: localeCode, name: countryName!))
        }
        completion(.success(countries))
    }
    
}
