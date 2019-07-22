//
//  FlickrPhotoApiResponse.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 22.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import Foundation

struct FlickrPagedImageResult: Codable {
    let photo : [FlickrURLs]?
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: Int?
}
