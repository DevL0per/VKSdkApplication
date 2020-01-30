//
//  NewsFeedImageView.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 28/01/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class NewsFeedImageView: UIImageView {
    
    func setImage(with url: String) {
        guard let url = URL(string: url) else { return }
        if let imageResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            self.image = UIImage(data: imageResponse.data)
            print("cached")
            return
        }
        
        print("internet")
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, let response = response else { return }
                self?.image = UIImage(data: data)
                self?.saveImageInCache(response: response, data: data)
            }
        }.resume()
    }
    
    private func saveImageInCache(response: URLResponse, data: Data) {
        guard let url = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: url))
    }
}

