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
    @IBOutlet weak var errorDescriptionLabel: UILabel!
    @IBOutlet weak var errorRefreshButton: UIButton!
    @IBOutlet weak var errorAnimationView: AnimationView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    //STATES
    @Published var isLoadingMore = false
    
    //VIEWMODELS
    var articleListVM = ArticleListViewModel(articles: [Article]())
    
    //USE CASES
    let headlinesUseCase = HeadlinesUseCaseImp()
    
    //DATA
    var currentPage = 1
    var pageSize = 20
    var searchText = ""
    
    //OBSERVERS
    var observers: [AnyCancellable] = []
    var isLoadingMoreCancellable : AnyCancellable?
    
    //Segues
    let gotoArticleDetail = "gotoArticleDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Controller
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name:Constants.Font.bold, size:18)!]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name:Constants.Font.bold, size:30)!]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: ColorUtils.hexStringToUIColor(hex: Constants.AppPalette.primaryColor)]
        
        setupTableViewDelegatesAndDataSource()
        setupInitialStates()
        search()
    }
    
    
    // MARK: - Data methods
    private func search(){
        showLoader()
        currentPage = 1
        headlinesUseCase.search(page: currentPage, pageSize: pageSize, searchText: searchText)
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
                self?.hideLoader()
                self?.articleListVM.refreshList(value)
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }).store(in: &observers)
    }
    
    private func loadMore(){
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
                    self.showErrorView(message: error.message)
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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if  segue.identifier == gotoArticleDetail,
            let destination = segue.destination as? ArticleViewController,
            let cell = sender as? HeadlinesTableViewCell,
            let indexPath = self.tableView.indexPath(for: cell)
        {
            destination.articleViewModel = articleListVM.articleAtIndex(indexPath.row)
        }
        
    }
}
