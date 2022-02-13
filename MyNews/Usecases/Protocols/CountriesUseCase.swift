//
//  CountriesUseCase.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation
import Combine

protocol CountriesUseCase {
    var selectedCountryCode: String { get set }
    func fetch() -> Future<[Country], APICallError>
    func search(searchText: String) -> Future<[Country], APICallError>
    func getCountryName(code: String) -> String 
}
