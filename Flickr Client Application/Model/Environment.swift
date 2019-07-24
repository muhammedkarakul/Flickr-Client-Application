//
//  AppConfig.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 23.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import Foundation

struct Environment {
    
    static let shared = Environment()
    
    let baseUrl = "https://api.flickr.com/services/rest/"

    let apiKey = "0b255075bbbf70c2f017bb10c4bbdc66"

    let format = "json"

    let secret = "8eac4175f638ff99"
}
