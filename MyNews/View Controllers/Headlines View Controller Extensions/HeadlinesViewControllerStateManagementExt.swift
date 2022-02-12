//
//  HeadlinesViewControllerStateManagementExt.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation
import UIKit

extension HeadlinesViewController {
    
    //MARK: - Error View
    
    func showErrorView(message: String) {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.errorDescriptionLabel.text = message
            self.errorView.isHidden = false
            self.errorAnimationView.play()
            self.hideLoader()
        }
    }
    
    func hideErrorView() {
        DispatchQueue.main.async {
            self.errorView.isHidden = true
            self.errorAnimationView.stop()
        }
    }
    
    //MARK: - Activity Indicator methods
    func showLoader() {
        DispatchQueue.main.async {
            self.errorView.isHidden = true
            self.activityIndicatorView.isHidden = false
            self.activityIndicatorView.startAnimating()
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = true
            self.activityIndicatorView.stopAnimating()
        }
    }
   
}
