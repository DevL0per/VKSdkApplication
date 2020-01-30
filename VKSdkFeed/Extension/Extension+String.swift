//
//  Extension+String.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 31/01/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

extension String {
    func getTextFrame(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return size.height
    }
}
