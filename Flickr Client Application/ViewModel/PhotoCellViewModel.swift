//
//  FlickrViewModel.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 11.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit

class PhotoCellViewModel: PhotoViewModel {
        
    func configure(_ cell: PhotoTableViewCell) {
        
        cell.buddyiconImageView.kf.setImage(with: buddyIconURL)
        cell.ownernameLabel.text = photo?.ownername
        cell.flickrImageView.kf.setImage(with: photo?.lowResPhotoUrl)
        cell.titleLabel.text = photo?.title
        
    }

}
