//
//  DetailView.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 22.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit
import SnapKit

class DetailView: UIView {
    
    // MARK: - Properties

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
    
    private(set) lazy var cellTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buddyiconImageView, ownernameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private(set) lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private(set) lazy var zoomScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
        return scrollView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cellTitleStackView, zoomScrollView, titleLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.backgroundColor = .red
        return stackView
    }()
    
    private(set) lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        return view
    }()
    
    // MARK: - Setup View
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .black
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        zoomScrollView.addSubview(photoImageView)
        
        setupContainerView()
        
        setupContainerStackView()
        
        setupOwnerNameLabel()
        
        setupTitleLabel()
        
        setupPhotoImageView()
        
        setupBuddyIconImageView()
        
    }
    
    // MARK: - Layout
    
    private func setupContainerView() {
        
        self.addSubview(containerView)
        
        containerView.addSubview(containerStackView)
        
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).inset(8)
            make.left.equalTo(8)
            make.bottom.right.equalTo(-8)
        }
    }
    
    private func setupContainerStackView() {
        containerStackView.snp.makeConstraints { (make) in
            make.top.left.equalTo(8)
            make.bottom.right.equalTo(-8)
        }
    }
    
    private func setupOwnerNameLabel() {
        ownernameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
    }
    
    private func setupTitleLabel() {
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
    }
    
    private func setupBuddyIconImageView() {
        buddyiconImageView.snp.makeConstraints { (make) in
            make.size.equalTo(48)
        }
    }
    
    private func setupPhotoImageView() {
        photoImageView.snp.makeConstraints { (make) in
            make.size.equalTo(zoomScrollView.snp.size)
        }
    }

}
