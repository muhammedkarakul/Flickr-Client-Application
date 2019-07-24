//
//  PagedImageViewModel.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 23.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import Foundation

struct PagedImageViewModel {
    
    var flickrPagedImage: FlickrPagedImageResult?
    
    init(flickrPagedImage: FlickrPagedImageResult) {
        self.flickrPagedImage = flickrPagedImage
    }
}
