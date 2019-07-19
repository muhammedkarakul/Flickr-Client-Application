//
//  DetailViewController.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 18.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit
import SVProgressHUD

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    public var photoViewModel: PhotoViewModel? {
        didSet {
            ownernameLabel.text = photoViewModel?.ownername
            
            if let url = photoViewModel?.highQualityImageUrl {
                
                SVProgressHUD.show()
                
                Service.getImage(withUrl: url, completion: { (response) in
                    
                    SVProgressHUD.dismiss()
                    
                    if let imageData = response.data {
                        
                        self.photoImageView.image = UIImage(data: imageData)
                        
                    }
                })
            }
            
            titleLabel.text = photoViewModel?.title
        }
    }
    
    private let ownernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ownernameLabel, photoImageView, titleLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
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
        
        setupViews()
    }
    
    private func setupViews() {
        
        view.addSubview(containerView)
    
        containerView.addSubview(containerStackView)
        
        containerView.snp.makeConstraints { (make) in
            make.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(8)
            make.bottom.right.equalTo(-8)
        }
        
        containerStackView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        
        ownernameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
    }

}
