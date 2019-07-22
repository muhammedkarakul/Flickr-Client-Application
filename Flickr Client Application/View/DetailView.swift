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

    let buddyiconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let ownernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var cellTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buddyiconImageView, ownernameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let zoomScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
        return scrollView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cellTitleStackView, zoomScrollView, titleLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.backgroundColor = .red
        return stackView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        self.addSubview(containerView)
        
        zoomScrollView.addSubview(photoImageView)
        
        containerView.addSubview(containerStackView)
        
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(8)
            make.bottom.right.equalTo(-8)
        }
        
        containerStackView.snp.makeConstraints { (make) in
            make.top.left.equalTo(8)
            make.bottom.right.equalTo(-8)
        }
        
        ownernameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        buddyiconImageView.snp.makeConstraints { (make) in
            make.size.equalTo(48)
        }
        
        photoImageView.snp.makeConstraints { (make) in
            make.size.equalTo(zoomScrollView.snp.size)
        }
        
    }

}
