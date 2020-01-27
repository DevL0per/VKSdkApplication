//
//  NewsFeedTableViewCell.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 27/01/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    
    private var topContectView = UIView()
    private var topViewImage = UIImageView()
    private var topViewNameLabel =  UILabel()
    private var topViewDateLabel = UILabel()
    
    private var centerTextLabel = UILabel()
    private var centerImageView = UIImageView()
    
    private var bottonContentView = UIView()
    
    private var likesImage = UIImageView()
    private var numberOfLikesLabel = UILabel()
    
    private var commentsImage = UIImageView()
    private var numberOfCommentsLabel = UILabel()
    
    private var repostImage = UIImageView()
    private var numberOfRepostLabel = UILabel()
    
    private var viewsImage = UIImageView()
    private var numberOfViewsLabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements(with post: NewsFeed.ShowNews.ViewModel.Cell) {
        topViewNameLabel.text = post.name
        topViewDateLabel.text = post.date
        
        centerTextLabel.text = post.postText
        numberOfLikesLabel.text = post.likesCount
        numberOfCommentsLabel.text = post.likesCount
        numberOfRepostLabel.text = post.repostCount
        numberOfViewsLabel.text = post.viewsCount
    }
    
    private func setupUI() {
        addSubview(topContectView)
        topContectView.translatesAutoresizingMaskIntoConstraints = false
        topContectView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topContectView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        topContectView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        topContectView.addSubview(topViewImage)
        topViewImage.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        topViewImage.translatesAutoresizingMaskIntoConstraints = false
        topViewImage.topAnchor.constraint(equalTo: topContectView.topAnchor, constant: 20).isActive = true
        topViewImage.leftAnchor.constraint(equalTo: topContectView.leftAnchor, constant: 20).isActive = true
        topViewImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        topViewImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        topContectView.addSubview(topViewNameLabel)
        topViewNameLabel.translatesAutoresizingMaskIntoConstraints = false
        topViewNameLabel.topAnchor.constraint(equalTo: topContectView.topAnchor, constant: 20).isActive = true
        topViewNameLabel.leftAnchor.constraint(equalTo: topViewImage.rightAnchor, constant: 10).isActive = true
        topViewNameLabel.rightAnchor.constraint(equalTo: topContectView.rightAnchor, constant: -20).isActive = true
        topViewNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        topViewNameLabel.text = "Label"
        
        topContectView.addSubview(topViewDateLabel)
        topViewDateLabel.translatesAutoresizingMaskIntoConstraints = false
        topViewDateLabel.topAnchor.constraint(equalTo: topViewNameLabel.bottomAnchor, constant: 5).isActive = true
        topViewDateLabel.leftAnchor.constraint(equalTo: topViewImage.rightAnchor, constant: 10).isActive = true
        topViewDateLabel.rightAnchor.constraint(equalTo: topContectView.rightAnchor, constant: -20).isActive = true
        topViewDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        topViewDateLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        topViewDateLabel.text = "Label"
        topViewDateLabel.font = topViewDateLabel.font.withSize(10)

        addSubview(centerTextLabel)
        centerTextLabel.translatesAutoresizingMaskIntoConstraints = false
        centerTextLabel.topAnchor.constraint(equalTo: topViewDateLabel.bottomAnchor, constant: 10).isActive = true
        centerTextLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        centerTextLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        centerTextLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(centerImageView)
        centerImageView.translatesAutoresizingMaskIntoConstraints = false
        centerImageView.topAnchor.constraint(equalTo: centerTextLabel.bottomAnchor, constant: 10).isActive = true
        centerImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        centerImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        centerImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(likesImage)
        likesImage.image = UIImage(named: "like")
        likesImage.translatesAutoresizingMaskIntoConstraints = false
        likesImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        likesImage.topAnchor.constraint(equalTo: centerImageView.bottomAnchor, constant: 10).isActive = true
        likesImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        likesImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(numberOfLikesLabel)
        numberOfLikesLabel.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        numberOfLikesLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfLikesLabel.topAnchor.constraint(equalTo: centerImageView.bottomAnchor, constant: 10).isActive = true
        numberOfLikesLabel.leftAnchor.constraint(equalTo: likesImage.rightAnchor, constant: 5).isActive = true
        numberOfLikesLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        numberOfLikesLabel.text = "0"
        
        addSubview(commentsImage)
        commentsImage.image = UIImage(named: "comment")
        commentsImage.translatesAutoresizingMaskIntoConstraints = false
        commentsImage.leftAnchor.constraint(equalTo: numberOfLikesLabel.rightAnchor, constant: 5).isActive = true
        commentsImage.topAnchor.constraint(equalTo: centerImageView.bottomAnchor, constant: 10).isActive = true
        commentsImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        commentsImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(numberOfCommentsLabel)
        numberOfCommentsLabel.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        numberOfCommentsLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfCommentsLabel.topAnchor.constraint(equalTo: centerImageView.bottomAnchor, constant: 10).isActive = true
        numberOfCommentsLabel.leftAnchor.constraint(equalTo: commentsImage.rightAnchor, constant: 10).isActive = true
        numberOfCommentsLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        numberOfCommentsLabel.text = "0"
        
        addSubview(repostImage)
        repostImage.image = UIImage(named: "repost")
        repostImage.translatesAutoresizingMaskIntoConstraints = false
        repostImage.leftAnchor.constraint(equalTo: numberOfCommentsLabel.rightAnchor, constant: 10).isActive = true
        repostImage.topAnchor.constraint(equalTo: centerImageView.bottomAnchor, constant: 10).isActive = true
        repostImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        repostImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(numberOfRepostLabel)
        numberOfRepostLabel.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        numberOfRepostLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfRepostLabel.topAnchor.constraint(equalTo: centerImageView.bottomAnchor, constant: 10).isActive = true
        numberOfRepostLabel.leftAnchor.constraint(equalTo: repostImage.rightAnchor, constant: 10).isActive = true
        numberOfRepostLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        numberOfRepostLabel.text = "0"
        
        addSubview(numberOfViewsLabel)
        numberOfViewsLabel.font = numberOfViewsLabel.font.withSize(15)
        numberOfViewsLabel.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        numberOfViewsLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfViewsLabel.topAnchor.constraint(equalTo: centerImageView.bottomAnchor, constant: 10).isActive = true
        numberOfViewsLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        numberOfViewsLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        numberOfViewsLabel.text = "0"
        
        addSubview(viewsImage)
        viewsImage.image = UIImage(named: "view")
        viewsImage.translatesAutoresizingMaskIntoConstraints = false
        viewsImage.rightAnchor.constraint(equalTo: numberOfViewsLabel.leftAnchor, constant: -10).isActive = true
        viewsImage.topAnchor.constraint(equalTo: centerImageView.bottomAnchor, constant: 10).isActive = true
        viewsImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        viewsImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    

}
