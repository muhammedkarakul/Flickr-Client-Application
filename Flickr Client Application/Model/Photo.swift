//
//  Flickr.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 11.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import UIKit

struct Photo: Decodable {
    var ownername: String?
    var lowQualityImageUrl: String?
    var highQualityImageUrl: String?
    var title: String?
    
    init(photo: [String : Any]) {
        self.ownername = photo["ownername"] as? String
        self.lowQualityImageUrl = photo["url_q"] as? String
        self.highQualityImageUrl = photo["url_z"] as? String
        self.title = photo["title"] as? String
    }
}
