//
//  Service.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 16.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

class Service {
    private static let baseUrl = "https://api.flickr.com/services/rest/"
    
    private static let api_key = "0b255075bbbf70c2f017bb10c4bbdc66"
    
    private static let format = "json"
    
    private static let secret = "8eac4175f638ff99"
    
    public static func getRecentPhotos(withPage page: String, completion: @escaping ([Photo]?, Error?) -> ()) {
        let parameters = [
            "method" : "flickr.photos.getRecent",
            "api_key" : api_key,
            "format" : format,
            "nojsoncallback" : "1",
            "extras" : "url_q,url_z,owner_name,date_upload"
        ]
        
        //request(withParameters: parameters, completion: completion)
        request(withParameters: parameters) { (response) in
            guard let data = response.data else { return }
            
            do {
                
                let json = try JSON(data: data)
                
                guard let photosArray = json["photos"]["photo"].array else { return }
                
                var photos = [Photo]()
                
                for item in photosArray {
                    if let photoDict = item.dictionaryObject {
                        photos.append(Photo(photo: photoDict))
                    }
                }
                
                DispatchQueue.main.async {
                    completion(photos, nil)
                }
                
            } catch let jsonError {
                SVProgressHUD.showError(withStatus: "Failed to decode: \(jsonError)")
            }

        }
    }
    
    public static func serachPhoto(withText text: String, completion: @escaping (DataResponse<Any>) -> Void) {
        let parameters = [
            "method" : "flickr.photos.search",
            "api_key" : api_key,
            "text" : text,
            "format" : format,
            "nojsoncallback" : "1",
            "extras" : "url_q,url_z,owner_name,date_upload"
        ]
        
        request(withParameters: parameters, completion: completion)
    }
    
    public static func getUser(withUserId id: String, completion: @escaping (DataResponse<Any>) -> Void) {
        let parameters = [
            "method" : "flickr.people.getInfo",
            "api_key" : api_key,
            "user_id" : id,
            "format" : format,
            "nojsoncallback" : "1"
        ]
        
        request(withParameters: parameters, completion: completion)
    }
    
    public static func getImage(withUrl url: String, completion: @escaping (DefaultDataResponse) -> Void) {
        Alamofire.request(url).response(completionHandler: completion)
    }
    
    private static func request(withParameters parameters: [String : String], completion: @escaping (DataResponse<Any>) -> Void) {
        
        Alamofire.request(
            baseUrl,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: nil
            ).responseJSON(completionHandler: completion)
    }
}
