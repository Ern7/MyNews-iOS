//
//  HeadlinesViewController.swift
//  MyNews
//
//  Created by Ernest Nyumbu on 2022/02/12.
//

import Foundation
import UIKit
import Combine
import Lottie

class HeadlinesViewController : UIViewController {
    
    
    //UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorTitleLabel: UILabel!
    @IBOutlet weak var errorDescriptionLabel: UILabel!
    @IBOutlet weak var errorRefreshButton: UIButton!
    @IBOutlet weak var errorAnimationView: AnimationView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var loadMoreViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var loadMorectivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var currentCountryLabel: UILabel!
    
    //STATES
    @Published var isLoadingMore = false
    
    //VIEWMODELS
    var articleListVM = ArticleListViewModel(articles: [Article]())
    
    //USE CASES
    let headlinesUseCase = HeadlinesUseCaseImp.shared
    let countriesUseCase = CountriesUseCaseImp.shared
    
    //DATA
    var currentPage = 1
    var pageSize = 15
    var searchText = ""
    
    //OBSERVERS
    var observers: [AnyCancellable] = []
    var isLoadingMoreCancellable : AnyCancellable?
    
    //Segues
    let gotoArticleDetail = "gotoArticleDetail"
    let goToCountries = "goToCountries"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Controller
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name:Constants.Font.bold, size:18)!]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name:Constants.Font.bold, size:30)!]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorUtils.hexStringToUIColor(hex: Constants.AppPalette.primaryColor)]
        
        setupTableViewDelegatesAndDataSource()
        adaptSelectedCountry()
        setupInitialStates()
        search()
    }
    
    
    // MARK: - Data methods
    func search(){
        showLoader()
        currentPage = 1
        headlinesUseCase.search(page: currentPage, pageSize: pageSize, searchText: searchText, country: countriesUseCase.selectedCountryCode)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    DebuggingLogger.printData("search finished")
                case .failure(let error):
                    DebuggingLogger.printData("Search results error: \(error.message)")
                    self.showErrorView(message: error.message)
                }
            }, receiveValue: { [weak self] value in
                DebuggingLogger.printData("Search results: \(value)")
                if value.isEmpty {
                    self?.articleListVM.clearItems()
                    self?.showEmptyView(message: "No articles found for this country.")
                }
                else {
                    self?.hideLoader()
                    self?.articleListVM.refreshList(value)
                    self?.tableView.isHidden = false
                }
                self?.tableView.reloadData()
            }).store(in: &observers)
    }
    
    func loadMore(){
        isLoadingMore = true
        currentPage = currentPage + 1
        headlinesUseCase.search(page: currentPage, pageSize: pageSize, searchText: searchText)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    DebuggingLogger.printData("Load more finished")
                case .failure(let error):
                    DebuggingLogger.printData("Load more error: \(error.message)")
                    self.isLoadingMore = false
                    let alert = UIAlertController(title: "Load More Error", message: error.message, preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                        
                    }))

                    self.present(alert, animated: true)
                }
            }, receiveValue: { [weak self] value in
                DebuggingLogger.printData("Load more results: \(value)")
                self?.isLoadingMore = false
                self?.articleListVM.addMore(value)
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }).store(in: &observers)
    }
   
    // MARK: - Actions
    @IBAction func refreshData(_ sender: Any) {
        search()
    }
    
    @IBAction func refreshHeadlines(_ sender: Any) {
        search()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == gotoArticleDetail,
            let destination = segue.destination as? ArticleViewController,
            let cell = sender as? HeadlinesTableViewCell,
            let indexPath = self.tableView.indexPath(for: cell)
        {
            destination.articleViewModel = articleListVM.articleAtIndex(indexPath.row)
        }
        else if segue.identifier == goToCountries {
            let vc = segue.destination as! CountriesViewController
            vc.delegate = self
        }
        
    }
}
