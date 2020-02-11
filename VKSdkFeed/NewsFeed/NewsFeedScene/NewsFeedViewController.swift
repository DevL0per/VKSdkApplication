//
//  NewsFeedViewController.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 27/01/2020.
//  Copyright (c) 2020 Роман Важник. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NewsFeedDisplayLogic: class {
    func displayNews(viewModel: NewsFeed.ShowNews.ViewModel)
    func displayUserInfo(viewModel: NewsFeed.ShowUserInfo.ViewModel)
    func displaySearchedGroups(viewModel: NewsFeed.SearchGroup.ViewModel)
}

class NewsFeedViewController: UIViewController, NewsFeedDisplayLogic {
    
    var interactor: NewsFeedBusinessLogic?
    var router: (NSObjectProtocol & NewsFeedRoutingLogic & NewsFeedDataPassing)?
    
    var newsTableView: UITableView!
    var newsFeedViewModel: NewsFeed.ShowNews.ViewModel?
    var newsFeedViewModelSearhResult: NewsFeed.ShowNews.ViewModel?
    
    var refreshControl: UIRefreshControl!
    
    let titleView = NavigationControllerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNewsTableView()
        setupNavigationBar()
        setupRefreshControl()
        interactor?.getNews(request: NewsFeed.ShowNews.Request())
        interactor?.getUserInfo(request: NewsFeed.ShowUserInfo.Request())
    }
    
    private func setupNewsTableView() {
        newsTableView = UITableView()
        view.addSubview(newsTableView)
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        newsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        newsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        newsTableView.contentInset.top = 10
        newsTableView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsFeedTableViewCell.self, forCellReuseIdentifier: "newsCell")
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print(scrollView.contentSize.height)
        if scrollView.contentOffset.y > scrollView.contentSize.height/2 {
            if newsFeedViewModel != nil {
                let request = NewsFeed.ShowPreviousNews.Request(newsFeedViewModel: newsFeedViewModel!)
                interactor?.showPreviousNews(request: request)
            }
        }
    }

    func displaySearchedGroups(viewModel: NewsFeed.SearchGroup.ViewModel) {
        newsFeedViewModelSearhResult = viewModel.resultOfSearching
        newsTableView.reloadData()
        newsTableView.layoutIfNeeded()
    }
    
    func displayNews(viewModel: NewsFeed.ShowNews.ViewModel) {
        DispatchQueue.main.async { [unowned self] in
            self.newsFeedViewModel = viewModel
            if !self.titleView.isSeachTextViewEmpty {
                self.textFieldWasEdited(text: self.titleView.navigationControllerTextView.text!)
            }
            self.newsTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func displayUserInfo(viewModel: NewsFeed.ShowUserInfo.ViewModel) {
        DispatchQueue.main.async { [unowned self] in
            self.titleView.setImage(imageURL: viewModel.imageURL)
        }
    }
    
    private func setupNavigationBar() {
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.titleView = titleView
        titleView.navigationControllerTextView.delegate = self
        titleView.delegate = self
        //titleView.navigationControllerTextView.addTarget(NewsFeedViewController.self, action: #selector(textFieldWasEdited), for: .editingChanged)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        newsTableView.refreshControl = refreshControl
        definesPresentationContext = true
    }
    
    @objc func refreshNews() {
        interactor?.getNews(request: NewsFeed.ShowNews.Request())
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = NewsFeedInteractor()
        let presenter = NewsFeedPresenter()
        let router = NewsFeedRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleView.isSeachTextViewEmpty ? newsFeedViewModel?.news.count ?? 0
            : newsFeedViewModelSearhResult?.news.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !titleView.isSeachTextViewEmpty {
            return newsFeedViewModelSearhResult?.news[indexPath.row].sizes.totalHeight ?? 0
        } else {
            return newsFeedViewModel?.news[indexPath.row].sizes.totalHeight ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsFeedTableViewCell
        cell.delegate = self
        var optionalViewModel: NewsFeed.ShowNews.ViewModel.Cell?
        if !titleView.isSeachTextViewEmpty {
            optionalViewModel = newsFeedViewModelSearhResult?.news[indexPath.row]
        } else {
            optionalViewModel = newsFeedViewModel?.news[indexPath.row]
        }
        guard let viewModel = optionalViewModel else { return UITableViewCell() }
        cell.setupElements(with: viewModel)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return newsFeedViewModel?.news[indexPath.row].sizes.totalHeight ?? 0
    }
    
}

extension NewsFeedViewController: NewsFeedTableViewCellDelegate {
    
    func fullTextRequest(postId: Int) {
        interactor?.showFullText(request: NewsFeed.ShowFullPostText.Request(postId: postId,
                                                                            newsFeedViewModel: newsFeedViewModel!))
    }
}

extension NewsFeedViewController: UITextFieldDelegate, NavigationControllerViewDelegate {
    
    func textFieldWasEdited(text: String) {
        if !text.isEmpty {
            let request = NewsFeed.SearchGroup.Request(sourceNewsFeedViewModel: newsFeedViewModel,
                                                       searchedGroupName: text)
            interactor?.searchGroupRequest(request: request)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }

}
