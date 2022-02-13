//
//  CountriesViewController.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation
import UIKit
import Combine

protocol CountriesViewControllerDelegate: AnyObject {
    func newCountrySelected(countryCode: String)
}

class CountriesViewController : UIViewController {
    
    //UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //VIEWMODELS
    var countriesListVM = CountryListViewModel(countries: [Country]())
    
    //USE CASES
    let countriesUseCase = CountriesUseCaseImp.shared
    let eventTrackingUseCase = EventTrackingUseCaseImp.shared
    
    //OBSERVERS
    var observers: [AnyCancellable] = []
    
    //DELEGATES
    weak var delegate: CountriesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        setupTableViewDelegatesAndDataSource()
        setupSearchBarDelegate()
        fetch()
    }
    
    // MARK: - Data methods
    func fetch(){
        countriesUseCase.fetch()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    DebuggingLogger.printData("countries fetch finished")
                case .failure(let error):
                    DebuggingLogger.printData("countries fetch error: \(error.message)")
                }
            }, receiveValue: { [weak self] value in
                DebuggingLogger.printData("countries fetch results: \(value)")
                self?.countriesListVM.refreshList(value)
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }).store(in: &observers)
    }
    
    func search(searchText: String){
        countriesUseCase.search(searchText: searchText)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    DebuggingLogger.printData("countries search finished")
                case .failure(let error):
                    DebuggingLogger.printData("countries search error: \(error.message)")
                }
            }, receiveValue: { [weak self] value in
                DebuggingLogger.printData("countries fetch results: \(value)")
                self?.countriesListVM.refreshList(value)
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }).store(in: &observers)
    }
}
