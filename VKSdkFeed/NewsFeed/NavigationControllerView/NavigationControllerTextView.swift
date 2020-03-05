//
//  NavigationControllerTextView.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 05/02/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class NavigationControllerTextView: UITextField  {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clearButtonMode = .whileEditing
        
        let image = UIImage(named: "search")
        leftView = UIImageView(image: image)
        leftViewMode = .always
        
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        placeholder = "Поиск..."
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var frame = super.leftViewRect(forBounds: bounds)
        frame.origin.x += 5
        frame.size.width = 18
        //frame.origin.y += 5
        frame.size.height = 18
        return frame
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 30, dy: 0)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 30, dy: 0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 30, dy: 0)
    }
}
