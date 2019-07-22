//
//  Service.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 16.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

class Service {
    private static let baseUrl = "https://api.flickr.com/services/rest/"
    
    private static let api_key = "0b255075bbbf70c2f017bb10c4bbdc66"
    
    private static let format = "json"
    
    private static let secret = "8eac4175f638ff99"
    
    public static func getRecentPhotos(completion: @escaping ([FlickrURLs]?, Error?) -> ()) {
        let parameters = [
            "method" : "flickr.photos.getRecent",
            "api_key" : api_key,
            "format" : format,
            "nojsoncallback" : "1",
            "extras" : "url_q,url_z,owner_name,date_upload"
        ]
        
        getPhotosFromRequest(withParameters: parameters, completion: completion)
    }
    
    public static func serachPhoto(withText text: String, completion: @escaping ([FlickrURLs]?, Error?) -> ()) {
        let parameters = [
            "method" : "flickr.photos.search",
            "api_key" : api_key,
            "text" : text,
            "format" : format,
            "nojsoncallback" : "1",
            "extras" : "url_q,url_z,owner_name,date_upload"
        ]
        
        getPhotosFromRequest(withParameters: parameters, completion: completion)
    }
    
    /**
     Gets photo objects from response of api. If photo object not available, return error.
     
     - Parameter parameters: To be sended parameters for flickr api.
     - Parameter completion: Carries photo objects or error object.
     */
    private static func getPhotosFromRequest(withParameters parameters: [String : String], completion: @escaping ([FlickrURLs]?, Error?) -> ()) {
        request(withParameters: parameters) { (response) in
            guard let data = response.data else { return }
            
            print("DATA: \(data)")
            
            do {
                let flickrImageResult = try JSONDecoder().decode(FlickrImageResult.self, from: data)
                
                guard let photos = flickrImageResult.photos?.photo else { return }
                
                DispatchQueue.main.async {
                    completion(photos, nil)
                }

            } catch (let error) {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            
        }
    }
    
    /**
     Base network request method.
     
     - Parameter parameters: To be sended parameters for flickr api.
     - Parameter completion: Carries returned response from api.
     */
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
