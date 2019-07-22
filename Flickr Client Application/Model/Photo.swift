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
    var buddyiconUrl: URL?
    var lowQualityImageUrl: URL?
    var highQualityImageUrl: URL?
    var title: String?
    
    init(photo: [String : Any]) {
        self.ownername = photo["ownername"] as? String
        
        guard let lowResPhotoUrlString = photo["url_q"] as? String else { return }
        self.lowQualityImageUrl = URL(string: lowResPhotoUrlString)
        
        guard let highResPhotoUrlString = photo["url_z"] as? String else { return }
        self.highQualityImageUrl = URL(string: highResPhotoUrlString)
        
        self.title = photo["title"] as? String
        
        
        guard let iconServer = photo["server"] else { return }
        guard let iconFarm = photo["farm"] else { return }
        guard let nsid = photo["owner"] else { return }
        
        self.buddyiconUrl = URL(string: "http://farm\(iconFarm).staticflickr.com/\(iconServer)/buddyicons/\(nsid).jpg")

        
    }
}
