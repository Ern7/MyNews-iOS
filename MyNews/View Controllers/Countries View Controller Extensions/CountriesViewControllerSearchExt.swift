//
//  CountriesViewControllerSearchExt.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/13.
//

import Foundation
import UIKit

extension CountriesViewController : UISearchBarDelegate {
    
    func setupSearchBarDelegate(){
        searchBar.delegate = self
    }
    
    // MARK: - Search Delegate methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        handleSearchText(searchText: searchBar.text!)
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetch()
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        handleSearchText(searchText: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    private func handleSearchText(searchText: String){
        if searchText.isEmpty {
            fetch()
        }
        else {
            search(searchText: searchText)
        }
    }

}
