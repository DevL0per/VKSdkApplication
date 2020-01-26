//
//  AppDelegate.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 24/01/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit
import VK_ios_sdk


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var authService: AuthService!
    
    var token: String? {
        VKSdk.accessToken()?.accessToken
    }
    
    static var shared: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        authService = AuthService()
        authService.delegate = self
        
        window = UIWindow()
        let rootVC: AuthViewController? = AuthViewController.loadVC()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }

}

extension AppDelegate: AuthDelegate {
    
    func shoulPresentLoginScreen(controller: UIViewController) {
        window?.rootViewController?.present(controller, animated: true, completion: nil) 
    }
    
    func sholdPresentNewsFeed() {
        let newsFeedVC: NewsFeedViewController = NewsFeedViewController.loadVC()!
        let navigationController = UINavigationController(rootViewController: newsFeedVC)
        window?.rootViewController?.present(navigationController, animated: true, completion: nil)
    }
}
