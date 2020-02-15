//
//  PhotosCollectionViewController.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 01/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class PhotosCollectionViewController: UICollectionView {

    fileprivate var photos: [NewsFeed.ShowNews.ViewModel.Attachment]?
    
    init() {
        let rowLayout = RowLayout()
        super.init(frame: .zero, collectionViewLayout: rowLayout)
        self.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        showsHorizontalScrollIndicator = true
        delegate = self
        dataSource = self
        if let rowLayout = collectionViewLayout as? RowLayout {
            rowLayout.delegate = self
        }
    }
    
    func setPhotos(photos: [NewsFeed.ShowNews.ViewModel.Attachment]) {
        self.photos = photos
        reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PhotosCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setImage(imageURL: photos?[indexPath.row].photoURL)
        return cell
    }
    
}

extension PhotosCollectionViewController: RowLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        let photo = photos?[indexPath.row]
        let sizes = CGSize(width: photo?.width ?? 0, height: photo?.height ?? 0)
        return sizes
    }
}
