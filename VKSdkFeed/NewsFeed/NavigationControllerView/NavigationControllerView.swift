//
//  NavigationControllerView.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 05/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

final class NavigationControllerView: UIView {
    
    private var navigationControllerTextView: NavigationControllerTextView
    private var rightImageView: NewsFeedImageView = {
        let imageView = NewsFeedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        navigationControllerTextView = NavigationControllerTextView()
        super.init(frame: frame)
        setupRightImageView()
        setupTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rightImageView.layer.cornerRadius = rightImageView.bounds.width / 2
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    func setImage(imageURL: String) {
        rightImageView.setImage(with: imageURL)
    }
    
    private func setupRightImageView() {
        addSubview(rightImageView)
        rightImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        rightImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rightImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        rightImageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    private func setupTextView() {
        addSubview(navigationControllerTextView)
        navigationControllerTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        navigationControllerTextView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        navigationControllerTextView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        navigationControllerTextView.trailingAnchor.constraint(equalTo: rightImageView.leadingAnchor, constant: -10).isActive = true
    }
}
