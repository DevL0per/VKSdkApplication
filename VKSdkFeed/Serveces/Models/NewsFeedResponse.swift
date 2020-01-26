//
//  NewsFeedResponse.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 26/01/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation

struct NewsFeedResponse: Decodable {
    let response: ItemsDataResponse
}

struct ItemsDataResponse: Decodable {
    var items: [ItemsData]
}

struct ItemsData: Decodable {
    let sourceId: Int?
    let postId: Int?
    let text: String?
    let comments: countOfItems?
    let likes: countOfItems?
    let reposts: countOfItems?
    //let views: countOfItems?
    
}

struct countOfItems: Decodable {
    let count: Int?
}
