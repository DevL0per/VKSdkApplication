//
//  UserInfoResponse.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 08/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation

struct UserInfoResponse: Decodable {
    let response: [Response]
}

struct Response: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
}
