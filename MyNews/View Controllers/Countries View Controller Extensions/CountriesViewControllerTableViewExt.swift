//
//  CountriesViewControllerTableViewExt.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation
import UIKit

extension CountriesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func setupTableViewDelegatesAndDataSource(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.countriesListVM.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countriesListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let countryViewModel = self.countriesListVM.countryAtIndex(indexPath.row)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.countriesTableViewCell, for: indexPath) as? CountriesTableViewCell else {
            fatalError()
        }
        cell.titleLabel?.text = countryViewModel.name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Change the selected background view of the cell.
        tableView.deselectRow(at: indexPath, animated: true)
        
        let countryViewModel = self.countriesListVM.countryAtIndex(indexPath.row)
        countriesUseCase.selectedCountryCode = countryViewModel.code
        delegate?.newCountrySelected(countryCode: countryViewModel.code)
        _ = navigationController?.popViewController(animated: true)
    }

}
