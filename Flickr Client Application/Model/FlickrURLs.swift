//
//  Flickr.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 11.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit

struct FlickrURLs: Codable {
    let owner : String?
    let ownername: String?
    let server: String?
    let farm: Int?
    let title: String?
    let lowResPhotoUrl: URL?
    let highResPhotoUrl: URL?
    
    private enum CodingKeys: String, CodingKey {
        case owner
        case ownername
        case server
        case farm
        case title
        case lowResPhotoUrl = "url_q"
        case highResPhotoUrl = "url_z"
    }
}
