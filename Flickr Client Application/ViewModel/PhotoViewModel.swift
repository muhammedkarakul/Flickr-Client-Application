//
//  FlickrViewModel.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 11.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoViewModel {
    
    var photo: FlickrURLs?
    var buddyIconURL: URL?
    
    // Dependency Injection (DI)
    init(photo: FlickrURLs) {
        self.photo = photo
        
        guard
            let farm = photo.farm,
            let server = photo.server,
            let owner = photo.owner
            else { return }
        
        buddyIconURL = URL(string: "http://farm\(farm).staticflickr.com/\(server)/buddyicons/\(owner).jpg")
    }
    
    func configure(_ cell: PhotoTableViewCell) {
        
        cell.buddyiconImageView.kf.setImage(with: buddyIconURL)
        cell.userNameLabel.text = photo?.owner
        cell.flickrImageView.kf.setImage(with: photo?.lowResPhotoUrl)
        cell.descriptionLabel.text = photo?.title
        
    }
    
    func configure(_ view: DetailView) {
        view.buddyiconImageView.kf.setImage(with: buddyIconURL)
        view.ownernameLabel.text = photo?.ownername
        view.photoImageView.kf.setImage(with: photo?.highResPhotoUrl)
        view.titleLabel.text = photo?.title
    }

}
