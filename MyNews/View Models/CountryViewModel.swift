//
//  CountryViewModel.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation

struct CountryViewModel {
    private let country: Country
}

extension CountryViewModel {
    init(_ country: Country) {
        self.country = country
    }
}

extension CountryViewModel {
    
    var code: String {
        return self.country.code
    }
    
    var name: String {
        return self.country.name
    }
    
}
