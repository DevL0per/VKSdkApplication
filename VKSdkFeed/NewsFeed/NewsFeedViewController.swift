//
//  NewsFeedViewController.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 26/01/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {

    var dataFetcher = DataFetcher<NewsFeedResponse>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataFetcher.fetchData { (news) in
            guard let news = news else { return }
            print(news)
        }
    }
}
