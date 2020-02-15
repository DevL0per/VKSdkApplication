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
    
    var loginButton: UIButton!
    var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = AppDelegate.shared.authService
        setupLoginButton()
    }
    
    @objc func login() {
        authService.isSessionAvailible()
    }
    
    private func setupLoginButton() {
        loginButton = UIButton()
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loginButton.backgroundColor = #colorLiteral(red: 0.368627451, green: 0.5098039216, blue: 0.662745098, alpha: 1)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Log in", for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }

}

