//
//  AuthService.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 25/01/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import Foundation
import VK_ios_sdk

protocol AuthDelegate: class {
    func shoulPresentLoginScreen(controller: UIViewController)
    func sholdPresentNewsFeed()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let vkSdk: VKSdk
    private let appID = "7293859"
    
    weak var delegate: AuthDelegate?
    
    override init() {
        self.vkSdk = VKSdk.initialize(withAppId: appID)
        super.init()
        
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func isSessionAvailible() {
        let scope = ["offline", "friends", "wall"]
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            if state == VKAuthorizationState.authorized {
                delegate?.sholdPresentNewsFeed()
            } else if state == VKAuthorizationState.initialized {
                VKSdk.authorize(scope)
            } else {
                print("ошибка")
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            delegate?.sholdPresentNewsFeed()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("vkSdkUserAuthorizationFailed")
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.shoulPresentLoginScreen(controller: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
}
