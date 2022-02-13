//
//  CountriesUseCaseImp.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation
import Combine
import FirebaseAnalytics

final class CountriesUseCaseImp {
    
    static let shared = CountriesUseCaseImp()
    private var _selectedCountryCode: String = "za" //default
}

extension CountriesUseCaseImp: CountriesUseCase {
    
    var selectedCountryCode: String {
        get {
            
            let userDefaults = UserDefaults.standard
            if let value = userDefaults.value(forKey: Constants.UserDefaultsKeys.Country) as? String {
                return value
            }
            
            return _selectedCountryCode
            
        } set {
            let userDefaults = UserDefaults.standard
            userDefaults.set(newValue, forKey: Constants.UserDefaultsKeys.Country)
        }
    }
    
    func fetch() -> Future<[Country], APICallError> {
        return Future { promixe in
            LocalDataService.shared.fetchCountries() { result in
                switch result {
                case .success(let response):
                    promixe(.success(response))
                case .failure(let error):
                    DebuggingLogger.printData(error)
                    promixe(.failure(error))
                }
            }
        }
    }
    
    func search(searchText: String) -> Future<[Country], APICallError> {
        return Future { promixe in
            LocalDataService.shared.searchCountry(searchText: searchText) { result in
                switch result {
                case .success(let response):
                    promixe(.success(response))
                case .failure(let error):
                    DebuggingLogger.printData(error)
                    promixe(.failure(error))
                }
            }
        }
    }
    
    
    func getCountryName(code: String) -> String {
        for localeCode in NSLocale.isoCountryCodes {
            if localeCode.lowercased() == code.lowercased() {
                let identifier = NSLocale(localeIdentifier: localeCode)
                let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
                return countryName!
            }
        }
        return ""
    }
    
    
}

