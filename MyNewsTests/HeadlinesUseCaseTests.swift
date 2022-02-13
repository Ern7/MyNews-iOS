//
//  HeadlinesUseCaseTests.swift
//  MyNewsTests
//
//  Created by Ernest Nyumbu on 2022/02/13.
//

@testable import MyNews
import XCTest
import Combine

class HeadlinesUseCaseTests : XCTestCase {
    
    var sut : HeadlinesUseCaseImp!
    var countriesUseCase : CountriesUseCaseImp!
    var currentPage: Int!
    var pageSize: Int!
    var searchText: String!
    
    var observers: [AnyCancellable]!
    
    override func setUp() {
        super.setUp()
        sut = HeadlinesUseCaseImp.shared
        countriesUseCase = CountriesUseCaseImp.shared
        currentPage = 1
        pageSize = 10
        searchText = ""
        observers = []
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        countriesUseCase = nil
        currentPage = nil
        pageSize = nil
        searchText = nil
        observers = nil
    }
    
    func testSearch(){
        let expectation = self.expectation(description: "fetch headlines")
    
        sut.search(page: currentPage, pageSize: pageSize, searchText: searchText, country: countriesUseCase.selectedCountryCode)
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
            }).store(in: &observers)
        
        self.waitForExpectations(timeout: 6.0, handler: nil)
    }
}
