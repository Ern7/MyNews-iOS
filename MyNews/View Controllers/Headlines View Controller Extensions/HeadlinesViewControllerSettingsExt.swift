//
//  HeadlinesViewControllerSettingsExt.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation

extension HeadlinesViewController : CountriesViewControllerDelegate {
    
    func adaptSelectedCountry(){
        currentCountryLabel.text = countriesUseCase.getCountryName(code: countriesUseCase.selectedCountryCode)
    }
    
    func newCountrySelected(countryCode: String) {
        adaptSelectedCountry()
        search()
    }
}
