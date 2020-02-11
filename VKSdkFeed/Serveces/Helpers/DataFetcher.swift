//
//  DataFetcher.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 26/01/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation

final class DataFetcher<T: Decodable> {
    
    func fetchData(startTime: String?, complition: @escaping (T?) -> ()) {
        var dictionary = ["filters": "post,photo"]
        if let startTime = startTime {
            dictionary["start_from"] = startTime
        }
        let apiService = APIService(dictionary: dictionary, path: URLStructure.path)
        apiService.getData() { (data, error) in
            if let error = error {
                print(error)
            }
            let data = self.decodeJSON(from: data)
            complition(data)
        }
    }

    func fetchUserData(complition: @escaping (T?) -> ()) {
        let dictionary = ["fields": "photo_100"]
        let apiService = APIService(dictionary: dictionary, path: URLStructure.userPath)
        apiService.getData() { (data, error) in
            if let error = error {
                print(error)
            }
            let data = self.decodeJSON(from: data)
            complition(data)
        }
    }
    
    private func decodeJSON(from data: Data?) -> T? {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data,
        let jsonData = try? jsonDecoder.decode(T.self, from: data)
        else { return nil }
        return jsonData
    }
    
}
