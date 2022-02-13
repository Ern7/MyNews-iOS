//
//  CountriesUseCaseTests.swift
//  MyNewsTests
//
//  Created by Ernest Nyumbu on 2022/02/13.
//

@testable import MyNews
import XCTest
import Combine

class CountriesUseCaseTests : XCTestCase {
    
    var sut : CountriesUseCaseImp!
    var observers: [AnyCancellable]!
    var positiveResultSearchText: String!
    var negativeResultSearchText: String!
    
    var countryWithValidIsoCode: Country!
    var countryWithInValidIsoCode: Country!
    
    var isoCountryCodeToTestSaving: String!
    
    
    override func setUp() {
        super.setUp()
        sut = CountriesUseCaseImp.shared
        observers = []
        positiveResultSearchText = "Au"
        negativeResultSearchText = "dlklfkhklfhlhflkh"
        countryWithValidIsoCode = Country(code: "za", name: "South Africa")
        countryWithInValidIsoCode = Country(code: "ljhjgljd", name: "None existent country")
        isoCountryCodeToTestSaving = "NGA"  //nigeria
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        observers = nil
        positiveResultSearchText = nil
        negativeResultSearchText = nil
        countryWithValidIsoCode = nil
        countryWithInValidIsoCode = nil
        isoCountryCodeToTestSaving = nil
        
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: Constants.UserDefaultsKeys.Country)
    }
    
    func testFetch(){
        let expectation = self.expectation(description: "fetch all countries")
    
        sut.fetch()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTAssertNotNil(error)
                }
            }, receiveValue: { value in
                XCTAssertNotNil(value)
                XCTAssertGreaterThan(value.count, 100)
            }).store(in: &observers)
        
        self.waitForExpectations(timeout: 6.0, handler: nil)
    }
    
    func testSearch_ShouldNotReturnAnEmptyList(){
        let expectation = self.expectation(description: "search countries and not return an empty list")
    
        sut.search(searchText: positiveResultSearchText)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTAssertNotNil(error)
                }
            }, receiveValue: { value in
                XCTAssertNotNil(value)
                XCTAssertGreaterThan(value.count, 0)
            }).store(in: &observers)
        
        self.waitForExpectations(timeout: 6.0, handler: nil)
    }
    
    func testSearch_ShouldReturnAnEmptyList(){
        let expectation = self.expectation(description: "search countries and return an empty list since no country matching the search text exists")
    
        self.sut.search(searchText: negativeResultSearchText)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTAssertNotNil(error)
                }
            }, receiveValue: { value in
                XCTAssertNotNil(value)
                XCTAssertEqual(value.count, 0)
            }).store(in: &observers)
        
        self.waitForExpectations(timeout: 6.0, handler: nil)
    }
    
    func testGetCountryName_ShouldReturnCorrectCountryName(){
        let result = self.sut.getCountryName(code: countryWithValidIsoCode.code)
        XCTAssertEqual(result, countryWithValidIsoCode.name)
    }
    
    func testGetCountryName_ShouldReturnEmptyStringBecauseIsoCodeIsInvalid(){
        let result = self.sut.getCountryName(code: countryWithInValidIsoCode.code)
        XCTAssertEqual(result, "")
    }
    
    func test_ShouldSaveSelectedCountry(){
        self.sut.selectedCountryCode = isoCountryCodeToTestSaving
        let userDefaults = UserDefaults.standard
        XCTAssertNotNil(userDefaults.value(forKey: Constants.UserDefaultsKeys.Country))
        XCTAssertEqual(userDefaults.value(forKey: Constants.UserDefaultsKeys.Country) as? String, isoCountryCodeToTestSaving)
    }
}

