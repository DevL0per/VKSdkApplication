//
//  Extension+ViewController .swift
//  VKSdkFeed
//
//  Created by Роман Важник on 26/01/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

extension UIViewController {
    class func loadVC<T: UIViewController>() -> T? {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let vc = storyboard.instantiateInitialViewController() as? T {
            return vc
        } else {
            return nil
        }
    }
}
