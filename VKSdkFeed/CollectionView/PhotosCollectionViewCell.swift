//
//  PhotosCollectionViewCell.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 01/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    var photo: NewsFeedImageView = {
        let image = NewsFeedImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        //image.contentMode = .scaleAspectFit
        image.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photo)
        
        photo.topAnchor.constraint(equalTo: topAnchor).isActive = true
        photo.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        photo.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        photo.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        photo.setImage(with: nil)
    }
    
    func setImage(imageURL: String?) {
        photo.setImage(with: imageURL)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
