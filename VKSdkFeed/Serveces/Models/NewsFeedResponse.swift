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
    var profiles: [Profiles]
    var groups: [Group]
}

struct ItemsData: Decodable {
    var sourceId: Int
    var postId: Int
    let text: String?
    let date: Double
    let comments: countOfItems?
    let likes: countOfItems?
    let reposts: countOfItems?
    let views: countOfItems?
    let attachments: [Attachments]?
}

struct Attachments: Decodable {
    let photo: Photo?
}

struct Photo: Decodable {
    let sizes: [PhotoSize]
    
    var photoWidth: Int {
        getPhotoSize().width
    }
    
    var photoHeight: Int {
        getPhotoSize().height
    }
    
    var photoURL: String {
        getPhotoSize().url
    }
    
    private func getPhotoSize() -> PhotoSize {
        if let size = sizes.first(where: { (photoSize) -> Bool in
            photoSize.type == "x" }) {
            return size
        } else if let size = sizes.last {
            return size
        } else {
            return PhotoSize(width: 0, height: 0, url: "", type: "")
        }
    }
    
    
}

struct PhotoSize: Decodable {
    let width: Int
    let height: Int
    let url: String
    let type: String
}

struct countOfItems: Decodable {
    let count: Int?
}

protocol profileInfo {
    var id: Int { get }
    var name: String { get }
    var photo100: String { get }
}

struct Profiles: Decodable, profileInfo {
    
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    
    var name: String {
        firstName + " " + lastName
    }
    
    var photo: String {
        photo100
    }
}

struct Group: Decodable, profileInfo {
    let id: Int
    let name: String
    let photo100: String
}
