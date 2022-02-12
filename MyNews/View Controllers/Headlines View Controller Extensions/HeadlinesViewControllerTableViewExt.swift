//
//  HeadlinesViewControllerTableViewExt.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation
import UIKit
import Kingfisher

extension HeadlinesViewController : UITableViewDelegate, UITableViewDataSource {
    
    func setupTableViewDelegatesAndDataSource(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let articleViewModel = self.articleListVM.articleAtIndex(indexPath.row)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.headlinesTableViewCell, for: indexPath) as? HeadlinesTableViewCell else {
            fatalError()
        }
        cell.titleLabel?.text = articleViewModel.title
        cell.subtitleLabel?.text = articleViewModel.subtitle
        
        let url = URL(string: articleViewModel.urlToImage)
        cell.photoImageView.kf.setImage(with: url)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Change the selected background view of the cell.
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.articleListVM.numberOfItems() - 1 {
            self.loadMore()
        }
    }

}
