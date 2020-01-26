//
//  AuthViewController.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 26/01/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit
import VK_ios_sdk

class AuthViewController: UIViewController {
    
    var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = AppDelegate.shared.authService
    }
    
    @IBAction func login() {
        authService.isSessionAvailible()
    }

}

