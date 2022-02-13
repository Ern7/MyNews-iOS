//
//  ArticleViewController.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation
import UIKit
import Kingfisher

class ArticleViewController : UIViewController {
    
    //UI
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var subtitleLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var photoImageView : UIImageView!
    @IBOutlet weak var photoImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    
    //VIEWMODEL
    public var articleViewModel: ArticleViewModel!
    
    //USECASES
    let eventTrackingUseCase = EventTrackingUseCaseImp.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        adaptData()
        eventTrackingUseCase.logArticleViewed(articleTitle: articleViewModel.title)
    }
    
    private func logArticleViewedEvent(){
        
    }
    
    private func adaptData(){
        titleLabel.text = articleViewModel.title
        subtitleLabel.text = articleViewModel.subtitle
        descriptionLabel.text = articleViewModel.content
        
        let url = URL(string: articleViewModel.urlToImage)
        photoImageView.kf.setImage(with: url)
    }
    
    // MARK: - Actions
    @IBAction func viewInbrowser(_ sender: Any) {
        if let url = URL(string: articleViewModel.url) {
            eventTrackingUseCase.logArticleViewedInBrowser(articleTitle: articleViewModel.title, articleUrl: articleViewModel.url)
            UIApplication.shared.open(url)
        }
    }
}
