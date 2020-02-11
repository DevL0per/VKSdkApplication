//
//  Extension+UIScrollView.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 11/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
}
