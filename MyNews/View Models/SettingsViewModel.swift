//
//  SettingsViewModel.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation

struct SettingsViewModel {
    
    private var _selectedCountryCode: String = "za" //default
    
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
    
}
