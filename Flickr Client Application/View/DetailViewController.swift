//
//  DetailViewController.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 18.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit
import SVProgressHUD
import Kingfisher

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Properties
    
    public var photoViewModel: PhotoViewModel? {
        didSet {
            ownernameLabel.text = photoViewModel?.ownername
            
            guard let photoUrlString = photoViewModel?.highQualityImageUrl else { return }
            let photoUrl = URL(string: photoUrlString)
            photoImageView.kf.setImage(with: photoUrl)
            
            guard let buddyiconUrlString = photoViewModel?.buddyiconUrl else { return }
            let buddyiconUrl = URL(string: buddyiconUrlString)
            buddyiconImageView.kf.setImage(with: buddyiconUrl)
            
            titleLabel.text = photoViewModel?.title
        }
    }
    
    private let buddyiconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let ownernameLabel: UILabel = {
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
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let zoomScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
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

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Photo Detail"
        
        zoomScrollView.delegate = self
        
        setupViews()
    }
    
    private func setupViews() {
        
        view.addSubview(containerView)
        
        zoomScrollView.addSubview(photoImageView)
    
        containerView.addSubview(containerStackView)
        
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
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
    
    // MARK: - UIScrollView Delegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }

}
