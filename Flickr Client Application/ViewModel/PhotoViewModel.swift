//
//  PhotoViewModel.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 24.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit

class PhotoViewModel {
    
    var photo: FlickrImage?
    var buddyIconURL: URL?
    
    // Dependency Injection (DI)
    init(photo: FlickrImage) {
        self.photo = photo
        
        guard
            let farm = photo.farm,
            let server = photo.server,
            let owner = photo.owner
            else { return }
        
        buddyIconURL = URL(string: "http://farm\(farm).staticflickr.com/\(server)/buddyicons/\(owner).jpg")
    }
}
