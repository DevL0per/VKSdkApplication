//
//  NewsFeedTableViewCell.swift
//  VKSdkFeed
//
//  Created by Роман Важник on 27/01/2020.
//  Copyright © 2020 Роман Важник. All rights reserved.
//

import UIKit

protocol NewsFeedTableViewCellDelegate {
    func fullTextRequest(postId: Int)
    func performImageZoomIn(imageView: UIImageView)
}

class NewsFeedTableViewCell: UITableViewCell, animationProtocolDelegate {
    
    var delegate: NewsFeedTableViewCellDelegate!
    
    private var cellViewModel: NewsFeed.ShowNews.ViewModel.Cell!
    
    private var backgroundLayer = UIView()
    private var textHideLineButton: UIButton = {
        let button = UIButton()
        button.setTitle("Показать полностью...", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.5415384173, blue: 0.6787981391, alpha: 1), for: .normal)
        button.contentVerticalAlignment = .center
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    private var gradientForAnimation = CAGradientLayer()
    private var photosCollectionView = PhotosCollectionViewController()
    private var topContectView = UIView()
    private var topViewImage = NewsFeedImageView()
    private var topViewNameLabel =  UILabel()
    private var topViewDateLabel = UILabel()
    
    private var centerTextLabel: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isEditable = false
        
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets.init(top: 0, left: -padding, bottom: 0, right: -padding)
        textView.dataDetectorTypes = .all
        return textView
    }()
    private var centerImageView = NewsFeedImageView()
    private var centerViewForAnimation = UIView()
    
    private var bottonContentView = UIView()
    
    private var likesImage = UIImageView()
    private var numberOfLikesLabel = UILabel()
    
    private var commentsImage = UIImageView()
    private var numberOfCommentsLabel = UILabel()
    
    private var repostImage = UIImageView()
    private var numberOfRepostLabel = UILabel()
    
    private var viewsImage = UIImageView()
    private var numberOfViewsLabel = UILabel()
    
    override func prepareForReuse() {
        topViewImage.setImage(with: nil)
        centerImageView.setImage(with: nil)
        stopAnimation()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutFirstLayer()
        layoutSecondLayer()
        layoutThirdLayer()
        textHideLineButton.addTarget(self, action: #selector(textHideLineButtonWasPressed), for: .touchUpInside)
        centerImageView.isUserInteractionEnabled = true
        centerImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageShoutZoomIn)))
        setupGradientForAnimation()
        //set delegate to stopAnimation when image will be set
        centerImageView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements(with post: NewsFeed.ShowNews.ViewModel.Cell) {
        cellViewModel = post
        topViewNameLabel.text = post.name
        topViewDateLabel.text = post.date
        centerTextLabel.text = post.postText
        numberOfLikesLabel.text = post.likesCount
        numberOfCommentsLabel.text = post.likesCount
        numberOfRepostLabel.text = post.repostCount
        numberOfViewsLabel.text = post.viewsCount
        centerViewForAnimation.layer.mask = nil
        
        centerTextLabel.frame = cellViewModel.sizes.postTexFrame
        bottonContentView.frame = cellViewModel.sizes.bottonViewSize
        textHideLineButton.frame = cellViewModel.sizes.textHideLine
        
        topViewImage.layer.cornerRadius = 25
        topViewImage.clipsToBounds = true
        topViewImage.setImage(with: post.profileImageURL)
        
        centerImageView.isHidden = true
        centerViewForAnimation.isHidden = true
        photosCollectionView.isHidden = true
        
        if let photos = post.photo, let photo = photos.first {
            if photos.count > 1 {
                photosCollectionView.frame = cellViewModel.sizes.postPhotoFrame
                photosCollectionView.isHidden = false
                photosCollectionView.setPhotos(photos: photos)
                photosCollectionView.backgroundColor = .clear
            } else if photos.count == 1 {
                centerImageView.isHidden = false
                centerViewForAnimation.isHidden = false
                let frame = cellViewModel.sizes.postPhotoFrame
                centerImageView.frame = frame
                centerViewForAnimation.frame = centerImageView.frame
                gradientForAnimation.frame = centerViewForAnimation.bounds
                centerViewForAnimation.layer.mask = gradientForAnimation
                startPhotoAnimation()
                centerImageView.setImage(with: photo.photoURL)
            }
        }
    }
    
    func showFullPostText(sizes: NewsFeed.ShowNews.ViewModel.Sizes) {
        centerTextLabel.frame = sizes.postTexFrame
        centerImageView.frame = sizes.postPhotoFrame
        bottonContentView.frame = sizes.bottonViewSize
        textHideLineButton.frame = sizes.textHideLine
    }
    
    @objc private func textHideLineButtonWasPressed() {
        delegate.fullTextRequest(postId: cellViewModel.postId)
    }
    
    @objc private func imageShoutZoomIn() {
        delegate.performImageZoomIn(imageView: centerImageView)
    }
    
    func stopAnimation() {
        gradientForAnimation.removeAnimation(forKey: "centerImageViewAnimation")
        gradientForAnimation.removeFromSuperlayer()
        centerViewForAnimation.isHidden = true
    }
    
    private func startPhotoAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -centerImageView.frame.width-50
        animation.toValue = centerImageView.frame.width+50
        animation.fillMode = .both
        animation.duration = 2
        
        let group = CAAnimationGroup()
        group.animations = [animation]
        group.duration = 2.5
        group.repeatCount = Float.infinity
        gradientForAnimation.add(group, forKey: "centerImageViewAnimation")
    }
    
    private func setupGradientForAnimation() {
        gradientForAnimation.colors = [UIColor.clear.cgColor,
                                       UIColor.white.cgColor,
                                       UIColor.clear.cgColor]
        gradientForAnimation.locations = [0, 0.5, 1]
    }
    
    private func layoutThirdLayer() {
        topContectView.addSubview(topViewImage)
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
        
        topContectView.addSubview(topViewDateLabel)
        topViewDateLabel.translatesAutoresizingMaskIntoConstraints = false
        topViewDateLabel.topAnchor.constraint(equalTo: topViewNameLabel.bottomAnchor, constant: 5).isActive = true
        topViewDateLabel.leftAnchor.constraint(equalTo: topViewImage.rightAnchor, constant: 10).isActive = true
        topViewDateLabel.rightAnchor.constraint(equalTo: topContectView.rightAnchor, constant: -20).isActive = true
        topViewDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        topViewDateLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        topViewDateLabel.font = topViewDateLabel.font.withSize(10)
        
        bottonContentView.addSubview(likesImage)
        likesImage.image = UIImage(named: "like")
        likesImage.translatesAutoresizingMaskIntoConstraints = false
        likesImage.leftAnchor.constraint(equalTo: bottonContentView.leftAnchor, constant: 10).isActive = true
        likesImage.topAnchor.constraint(equalTo: bottonContentView.topAnchor, constant: 0).isActive = true
        likesImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        likesImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        bottonContentView.addSubview(numberOfLikesLabel)
        numberOfLikesLabel.font = numberOfLikesLabel.font.withSize(14)
        numberOfLikesLabel.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        numberOfLikesLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfLikesLabel.topAnchor.constraint(equalTo: bottonContentView.topAnchor, constant: 0).isActive = true
        numberOfLikesLabel.leftAnchor.constraint(equalTo: likesImage.rightAnchor, constant: 5).isActive = true
        numberOfLikesLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        bottonContentView.addSubview(commentsImage)
        commentsImage.image = UIImage(named: "comment")
        commentsImage.translatesAutoresizingMaskIntoConstraints = false
        commentsImage.leftAnchor.constraint(equalTo: numberOfLikesLabel.rightAnchor, constant: 10).isActive = true
        commentsImage.topAnchor.constraint(equalTo: bottonContentView.topAnchor, constant: 0).isActive = true
        commentsImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        commentsImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        bottonContentView.addSubview(numberOfCommentsLabel)
        numberOfCommentsLabel.font = numberOfCommentsLabel.font.withSize(14)
        numberOfCommentsLabel.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        numberOfCommentsLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfCommentsLabel.topAnchor.constraint(equalTo: bottonContentView.topAnchor, constant: 0).isActive = true
        numberOfCommentsLabel.leftAnchor.constraint(equalTo: commentsImage.rightAnchor, constant: 5).isActive = true
        numberOfCommentsLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        bottonContentView.addSubview(repostImage)
        repostImage.image = UIImage(named: "repost")
        repostImage.translatesAutoresizingMaskIntoConstraints = false
        repostImage.leftAnchor.constraint(equalTo: numberOfCommentsLabel.rightAnchor, constant: 10).isActive = true
        repostImage.topAnchor.constraint(equalTo: bottonContentView.topAnchor, constant: 0).isActive = true
        repostImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        repostImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        bottonContentView.addSubview(numberOfRepostLabel)
        numberOfRepostLabel.font = numberOfRepostLabel.font.withSize(14)
        numberOfRepostLabel.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        numberOfRepostLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfRepostLabel.topAnchor.constraint(equalTo: bottonContentView.topAnchor, constant: 0).isActive = true
        numberOfRepostLabel.leftAnchor.constraint(equalTo: repostImage.rightAnchor, constant: 5).isActive = true
        numberOfRepostLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        bottonContentView.addSubview(numberOfViewsLabel)
        numberOfViewsLabel.textAlignment = .right
        numberOfViewsLabel.font = numberOfViewsLabel.font.withSize(14)
        numberOfViewsLabel.textColor = #colorLiteral(red: 0.5058823529, green: 0.5490196078, blue: 0.6, alpha: 1)
        numberOfViewsLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfViewsLabel.topAnchor.constraint(equalTo: bottonContentView.topAnchor, constant: 0).isActive = true
        numberOfViewsLabel.rightAnchor.constraint(equalTo: bottonContentView.rightAnchor, constant: -10).isActive = true
        
        bottonContentView.addSubview(viewsImage)
        viewsImage.image = UIImage(named: "view")
        viewsImage.translatesAutoresizingMaskIntoConstraints = false
        viewsImage.rightAnchor.constraint(equalTo: numberOfViewsLabel.leftAnchor, constant: -5).isActive = true
        viewsImage.topAnchor.constraint(equalTo: bottonContentView.topAnchor, constant: 0).isActive = true
        viewsImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        viewsImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    private func layoutSecondLayer() {
        backgroundLayer.addSubview(topContectView)
        backgroundColor = #colorLiteral(red: 0.368627451, green: 0.5098039216, blue: 0.662745098, alpha: 1)
        topContectView.translatesAutoresizingMaskIntoConstraints = false
        topContectView.topAnchor.constraint(equalTo: backgroundLayer.topAnchor).isActive = true
        topContectView.leftAnchor.constraint(equalTo: backgroundLayer.leftAnchor).isActive = true
        topContectView.rightAnchor.constraint(equalTo: backgroundLayer.rightAnchor).isActive = true
        topContectView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        backgroundLayer.addSubview(centerTextLabel)
        centerTextLabel.font = UIFont.systemFont(ofSize: 15)
        
        backgroundLayer.addSubview(centerImageView)
        backgroundLayer.addSubview(centerViewForAnimation)
        centerImageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        centerViewForAnimation.backgroundColor = .white
        
        backgroundLayer.addSubview(bottonContentView)
        backgroundLayer.addSubview(photosCollectionView)
        backgroundLayer.addSubview(textHideLineButton)
    }
    
    private func layoutFirstLayer() {
        addSubview(backgroundLayer)
        backgroundLayer.layer.cornerRadius = 10
        backgroundLayer.clipsToBounds = true
        backgroundLayer.backgroundColor = .white
        backgroundLayer.translatesAutoresizingMaskIntoConstraints = false
        backgroundLayer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundLayer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        backgroundLayer.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        backgroundLayer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
    }
    
}
