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

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var detailView = DetailView()
    
    public var photoViewModel: PhotoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    private func setupViews() {
        
        title = "Photo Detail"
        
        photoViewModel?.configure(detailView)
        
        view.addSubview(detailView)
        
        detailView.zoomScrollView.delegate = self
        
        detailView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
    }
    
}

// MARK: - UIScrollView Delegate

extension DetailViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailView.photoImageView
    }
}
