//
//  FlickrTableViewCell.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 11.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "cell"
    
    private(set) lazy var buddyiconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private(set) lazy var ownernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var cellTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buddyiconImageView, ownernameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private(set) lazy var  flickrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) lazy var  titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private lazy var flickrStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cellTitleStackView, flickrImageView, titleLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var  containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        return view
    }()
    
    // MARK: - Setup View

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        selectionStyle = .none
        
        setupViews()
    }
    
    private func setupViews() {
        
        setupContainerView()
        
        setupFlickrStackView()
        
        setupBuddyIconImageView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func setupContainerView() {
        
        addSubview(containerView)
        
        containerView.snp.makeConstraints { (make) in
            make.top.left.equalTo(8)
            make.bottom.right.equalTo(-8)
        }
    }
    
    private func setupFlickrStackView() {
        
        containerView.addSubview(flickrStackView)
        
        flickrStackView.snp.makeConstraints { (make) in
            make.top.left.equalTo(8)
            make.bottom.right.equalTo(-8)
        }
        
    }
    
    private func setupBuddyIconImageView() {
        buddyiconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(48)
        }
    }
    
}
