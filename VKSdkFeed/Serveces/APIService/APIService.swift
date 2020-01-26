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
    
    static var shared = APIService()
    
    func getData(complition: @escaping (Data?, Error?)->()) {
        guard let url = getURL(parameters: createParameters()) else { return }
        URLSession.shared.dataTask(with: url) { (data, respons, error) in
            complition(data, error)
        }.resume()
    }
    
    private func getURL(parameters: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = URLStructure.scheme
        components.host = URLStructure.host
        components.path = URLStructure.path
        components.queryItems = createParameters().map({ (key: String, value: String) -> URLQueryItem in
            URLQueryItem(name: key, value: value)
        })
        guard let url = components.url else { return nil }
        return url
    }
    
    private func createParameters() -> [String: String] {
        var dictionary: [String: String] = [:]
        let token = AppDelegate.shared.token
        dictionary["v"] = URLStructure.version
        dictionary["access_token"] = token
        dictionary["filters"] = "post,photo"
        return dictionary
    }
}
