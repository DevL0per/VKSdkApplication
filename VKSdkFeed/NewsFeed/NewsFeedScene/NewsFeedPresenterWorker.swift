//
//  NewsFeedWorker.swift
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

protocol NewsFeedPresenterWorkerProtocol {
    var sizesManager: SizesManager { get }
    func getNewsFeedViewModel(from item: ItemsData, profiles: [Profiles], groups: [Group]) -> NewsFeed.ShowNews.ViewModel.Cell
    func getPhotos(from item: ItemsData) -> [NewsFeed.ShowNews.ViewModel.Attachment]?
}

class NewsFeedPresenterWorker: NewsFeedPresenterWorkerProtocol {
    
    var sizesManager = SizesManager(viewWidth: UIScreen.main.bounds.width)
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "MMM d, h:mm"
        return dateFormatter
    }()
    
    func getPhotos(from item: ItemsData) -> [NewsFeed.ShowNews.ViewModel.Attachment]? {
        let attachments = item.attachments?.compactMap({ (attachment) -> NewsFeed.ShowNews.ViewModel.Attachment? in
            if let photo = attachment.photo {
                return NewsFeed.ShowNews.ViewModel.Attachment(photoURL: photo.photoURL, width: photo.photoWidth, height: photo.photoHeight)
            } else { return nil }
        })
        return attachments
    }
    
    func getNewsFeedViewModel(from item: ItemsData, profiles: [Profiles], groups: [Group]) -> NewsFeed.ShowNews.ViewModel.Cell {
        let profile = getProfile(sourceId: item.sourceId, profiles: profiles, groups: groups)
        let date = Date(timeIntervalSince1970: item.date)
        let dateString = dateFormatter.string(from: date)
        let cell = NewsFeed.ShowNews.ViewModel.Cell(name: profile.name,
                                                    date: dateString,
                                                    postText: item.text ?? "",
                                                    postId: item.postId ,
                                                    likesCount: formatNumber(number: item.likes?.count),
                                                    commentsCount: formatNumber(number: item.comments?.count),
                                                    repostCount: formatNumber(number: item.reposts?.count),
                                                    viewsCount: formatNumber(number: item.views?.count),
                                                    profileImageURL: profile.photo100,
                                                    photo: getPhotos(from: item),
                                                    sizes: sizesManager.getSizes(text: item.text, attacments: getPhotos(from: item), fullTextWillShow: false)
        )
        return cell
    }
    
    private func getProfile(sourceId: Int, profiles: [Profiles], groups: [Group] ) -> profileInfo {
        if sourceId < 0 {
            let group = groups.first { (group) in
                group.id == -sourceId
            }
            return group!
        } else {
            let profile = profiles.first { (profile) in
                profile.id == sourceId
            }
            return profile!
        }
    }
    
    private func formatNumber(number: Int?) -> String {
        guard let number = number else { return "0" }
        var stringNumber = String(number)
        if stringNumber.count == 4 || stringNumber.count == 5 {
            stringNumber = String(stringNumber.dropLast(3))
            stringNumber+="k"
        } else if stringNumber.count >= 6 {
            stringNumber = String(stringNumber.dropLast(5))
            stringNumber+="m"
        }
        return stringNumber
    }
    
}