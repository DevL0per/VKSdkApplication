//
//  SizesManager.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 31/01/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

struct Constants {
    static let backgroundViewSizes = UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8)
    static let bottomViewHeight: CGFloat = 60
    static let topViewHeight: CGFloat = 70
    static let postText = UIEdgeInsets(top: Constants.topViewHeight + 8, left: 8, bottom: 0, right: 8)
    static let postTextMaxLines = 7
    static let font = UIFont.systemFont(ofSize: 15)
    static let maxHeight = Constants.font.lineHeight * CGFloat(Constants.postTextMaxLines)
}

class SizesManager {
    
    private var viewWidth: CGFloat
    
    init(viewWidth: CGFloat) {
        self.viewWidth = viewWidth
    }
    
    func getSizes(text: String?, attacments: Attachments?, fullTextWillShow: Bool) -> NewsFeed.ShowNews.ViewModel.Sizes {
    
        var textSize = CGRect.zero
        var textHideButton = CGRect.zero
        
        let backgroundViewWidth = viewWidth - Constants.backgroundViewSizes.left -
            Constants.backgroundViewSizes.right
        
        
        if let text = text, !text.isEmpty {
            let textWidth = backgroundViewWidth - Constants.postText.right -
                Constants.postText.left
            var height = text.getTextFrame(width: textWidth,
                                           font: Constants.font)
            if !fullTextWillShow && height > Constants.maxHeight {
                height = Constants.maxHeight
                textHideButton = CGRect(origin: CGPoint(x: 8, y: Constants.maxHeight+Constants.topViewHeight+8),
                                        size: CGSize(width: textWidth, height: 30))
            }
            let size = CGSize(width: textWidth, height: height)
            textSize = CGRect(origin: CGPoint(x: 16, y: Constants.postText.top), size: size)
        }
        
        var attachmentSize = CGRect.zero
        let maxTextY = max(textSize.maxY + 8, textHideButton.maxY + 8)
        
        if let photoAttachmets = attacments?.photo {
            let topPosition = textSize.size == CGSize.zero ? Constants.topViewHeight + 8 : maxTextY
            let ratio: CGFloat = CGFloat(photoAttachmets.photoHeight) / CGFloat(photoAttachmets.photoWidth)
            let photoFrame = CGSize(width: backgroundViewWidth, height: CGFloat(photoAttachmets.photoHeight) * ratio)
            attachmentSize = CGRect(origin: CGPoint(x: 8, y: topPosition), size: photoFrame)
        }
        
        let bottomViewTop = max(attachmentSize.maxY, maxTextY) + 10
        let bottomFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                 size: CGSize(width: backgroundViewWidth,
                                              height: Constants.bottomViewHeight))
        
        let totalSizeFrame = bottomFrame.maxY
        
        return NewsFeed.ShowNews.ViewModel.Sizes(postPhotoFrame: attachmentSize,
                                                 postTexFrame: textSize,
                                                 bottonViewSize: bottomFrame,
                                                 totalHeight: totalSizeFrame,
                                                 textHideLine: textHideButton)
    }
}
