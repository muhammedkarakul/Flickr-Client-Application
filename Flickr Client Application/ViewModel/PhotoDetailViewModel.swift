//
//  PhotoTableViewModel.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 24.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit

class PhotoDetailViewModel: PhotoViewModel {
    
    func configure(_ view: DetailView) {
        view.buddyiconImageView.kf.setImage(with: buddyIconURL)
        view.ownernameLabel.text = photo?.ownername
        view.photoImageView.kf.setImage(with: photo?.highResPhotoUrl)
        view.titleLabel.text = photo?.title
    }
}
