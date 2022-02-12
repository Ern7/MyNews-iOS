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
    
    func setupInitialStates(){
        errorAnimationView.contentMode = .scaleAspectFit
        errorAnimationView.loopMode = .loop
        errorAnimationView.animationSpeed = 0.5
        hideErrorView()
        
        isLoadingMoreCancellable = self.$isLoadingMore
            .sink() {
                if $0 {
                    self.loadMoreViewHeightConstraint.constant = 50.0
                    self.loadMorectivityIndicatorView.startAnimating()
                    self.loadMorectivityIndicatorView.isHidden = false
                }
                else {
                    self.loadMoreViewHeightConstraint.constant = 0.0
                    self.loadMorectivityIndicatorView.stopAnimating()
                    self.loadMorectivityIndicatorView.isHidden = true
                }
        }
    }
    
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
