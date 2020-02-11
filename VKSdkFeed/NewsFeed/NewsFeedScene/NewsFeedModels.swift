//
//  NewsFeedModels.swift
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

enum NewsFeed {
    // MARK: Use cases
    
    enum ShowNews {
        struct Request {
        }
        
        struct Response {
            let newsFeedResponse: NewsFeedResponse
        }
        
        struct ViewModel {
            struct Cell {
                let name: String
                let date: String
                let postText: String
                let postId: Int
                let likesCount: String
                let commentsCount: String
                let repostCount: String
                let viewsCount: String
                let profileImageURL: String
                var photo: [Attachment]?
                var sizes: Sizes
            }
            struct Attachment {
                let photoURL: String?
                let width: Int
                let height: Int
            }
            
            struct Sizes {
                let postPhotoFrame: CGRect
                let postTexFrame: CGRect
                let bottonViewSize: CGRect
                let totalHeight: CGFloat
                let textHideLine: CGRect
            }
            
            var news: [Cell]
        }
    }
    
    enum ShowPreviousNews {
        struct Request {
            var newsFeedViewModel: NewsFeed.ShowNews.ViewModel
        }
        
        struct Response {
            var newsFeedViewModel: NewsFeed.ShowNews.ViewModel
            let newsFeedResponse: NewsFeedResponse
        }
        
        struct ViewModel {
            var newsFeedViewModel: NewsFeed.ShowNews.ViewModel
        }
    }
    
    enum SearchGroup {
        struct Request {
            var sourceNewsFeedViewModel: NewsFeed.ShowNews.ViewModel?
            var searchedGroupName: String
        }
        
        struct Response {
            var resultOfSearching: NewsFeed.ShowNews.ViewModel?
        }
        
        struct ViewModel {
            var resultOfSearching: NewsFeed.ShowNews.ViewModel?
        }
    }
    
    enum ShowFullPostText {
        struct Request {
            let postId: Int
            var newsFeedViewModel: NewsFeed.ShowNews.ViewModel
        }
        
        struct Response {
            let postId: Int
            var newsFeedViewModel: NewsFeed.ShowNews.ViewModel
        }
        
        struct ViewModel {
            var newsFeedViewModel: NewsFeed.ShowNews.ViewModel
        }
        
    }
    
    enum ShowUserInfo {
        struct Request {
        }
        
        struct Response {
            var userInfoResponse: UserInfoResponse
        }
        
        struct ViewModel {
            let fullName: String
            let imageURL: String
        }
    }
}
