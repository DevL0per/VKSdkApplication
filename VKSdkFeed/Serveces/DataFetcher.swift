//
//  DataFetcher.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 26/01/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation

final class DataFetcher<T: Decodable> {
    
    func fetchData(complition: @escaping (T?) -> ()) {
        APIService.shared.getData { (data, error) in
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
       // jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//        if let jsonDataOne =  try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//            print(jsonDataOne["groups"])
//        }
//        do {
//            let jsonData = try JSONDecoder().decode(T.self, from: data!)
//        } catch {
//            print(error)
//        }
        guard let data = data,
        let jsonData = try? jsonDecoder.decode(T.self, from: data)
        else { return nil }
        return jsonData
    }
    
}
