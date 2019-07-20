//
//  FlickrTableViewCell.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 11.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class PhotoTableViewCell: UITableViewCell {
    
    static let identifier = "cell"
    
    var photoViewModel: PhotoViewModel! {
        didSet {
            userNameLabel.text = photoViewModel.ownername
            
            if let url = photoViewModel.lowQualityImageUrl {
                
                SVProgressHUD.show()
                
                Service.getImage(withUrl: url, completion: { (response) in
                    
                    SVProgressHUD.dismiss()
    
                    if let imageData = response.data {
    
                        self.flickrImageView.image = UIImage(data: imageData)
    
                    }
                })
            }
            
            if let buddyiconUrl = photoViewModel.buddyiconUrl {
                
                
                print("BUDDYICON_URL: \(buddyiconUrl)")
                
                SVProgressHUD.show()
                
                Service.getImage(withUrl: buddyiconUrl, completion: { (response) in
                    
                    SVProgressHUD.dismiss()
                    
                    if let imageData = response.data {
                        
                        self.buddyiconImageView.image = UIImage(data: imageData)
                        
                    }
                })
            }
            
            descriptionLabel.text = photoViewModel.title
            
        }
    }
    
    let buddyiconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var cellTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buddyiconImageView, userNameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    let flickrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var flickrStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [cellTitleStackView, flickrImageView, descriptionLabel])
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = UIColor(white: 0.1, alpha: 1.0)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(containerView)
        containerView.addSubview(flickrStackView)
        
        containerView.snp.makeConstraints { (make) in
            make.top.left.equalTo(8)
            make.bottom.right.equalTo(-8)
        }
        
        flickrStackView.snp.makeConstraints { (make) in
            make.top.left.equalTo(8)
            make.bottom.right.equalTo(-8)
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        buddyiconImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(48)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
