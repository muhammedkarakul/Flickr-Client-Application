//
//  FlickrViewModel.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 11.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit

class PhotoViewModel {
    
    var ownername: String?
    var buddyiconUrl: URL?
    var lowQualityImageUrl: URL?
    var highQualityImageUrl: URL?
    var title: String?
    
    // Dependency Injection (DI)
    init(photo: Photo) {
        ownername = photo.ownername
        buddyiconUrl = photo.buddyiconUrl
        lowQualityImageUrl = photo.lowQualityImageUrl
        highQualityImageUrl = photo.highQualityImageUrl
        title = photo.title
        
    }

}
