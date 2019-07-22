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
    
    private let detailView = DetailView(frame: UIScreen.main.bounds)
    
    public var photoViewModel: PhotoViewModel? {
        didSet {
            detailView.ownernameLabel.text = photoViewModel?.ownername
            
            detailView.photoImageView.kf.setImage(with: photoViewModel?.highQualityImageUrl)
            
            detailView.buddyiconImageView.kf.setImage(with: photoViewModel?.buddyiconUrl)
            
            detailView.titleLabel.text = photoViewModel?.title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
    }
    
    private func setupViews() {
        
        title = "Photo Detail"
        
        detailView.zoomScrollView.delegate = self
    }
    


}

// MARK: - UIScrollView Delegate

extension DetailViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailView.photoImageView
    }
}
