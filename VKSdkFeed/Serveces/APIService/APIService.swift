//
//  APIService.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 26/01/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation
import VK_ios_sdk

final class APIService {
    
    private var dictionary: [String: String]
    private var path: String
    
    init(dictionary: [String: String], path: String) {
        self.dictionary = dictionary
        self.path = path
    }
    
    func getData(complition: @escaping (Data?, Error?)->()) {
        guard let url = getURL() else { return }
        URLSession.shared.dataTask(with: url) { (data, respons, error) in
            complition(data, error)
        }.resume()
    }
    
    private func getURL() -> URL? {
        var components = URLComponents()
        components.scheme = URLStructure.scheme
        components.host = URLStructure.host
        components.path = path
        components.queryItems = createParameters().map({ (key: String, value: String) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        })
        guard let url = components.url else { return nil }
        return url
    }
    
    private func createParameters() -> [String: String] {
        let token = AppDelegate.shared.token
        dictionary["v"] = URLStructure.version
        dictionary["access_token"] = token
        return dictionary
    }
}
