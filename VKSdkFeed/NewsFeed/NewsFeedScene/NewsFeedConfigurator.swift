//
//  NewsFeedConfigurator.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 15/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation

protocol NewsFeedConfiguratorProtocol: class {
    func configure(view: NewsFeedViewController)
}

class NewsFeedConfigurator: NewsFeedConfiguratorProtocol {
    func configure(view: NewsFeedViewController) {
        let interactor = NewsFeedInteractor()
        let presenter = NewsFeedPresenter()
        let router = NewsFeedRouter()
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.viewController = view
        router.viewController = view
        router.dataStore = interactor
    }
}
