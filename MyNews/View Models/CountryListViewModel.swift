//
//  CountryListViewModel.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation
import Combine

class CountryListViewModel {
    private var countries: [Country]
    
    init(countries: [Country]) {
        self.countries = countries
    }
}

extension CountryListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.countries.count
    }
    
    func countryAtIndex(_ index: Int) -> CountryViewModel {
        let country = self.countries[index]
        return CountryViewModel(country)
    }
    
    func refreshList(_ countries: [Country]) {
        clearItems()
        self.countries.append(contentsOf: countries)
    }
    
    func addMore(_ countrys: [Country]) {
        self.countries.append(contentsOf: countries)
    }
    
    func clearItems() {
        if !self.countries.isEmpty {
            self.countries.removeAll()
        }
    }
    
    func numberOfItems() -> Int {
        return self.countries.count
    }
    
}
