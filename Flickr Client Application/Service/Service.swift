//
//  Service.swift
//  Flickr Client Application
//
//  Created by Muhammed Karakul on 16.07.2019.
//  Copyright © 2019 Muhammed Karakul. All rights reserved.
//

import Foundation
import Alamofire

class Service {
    
    static let shared = Service()
    
//    public func getRecentPhotos(completion: @escaping ([FlickrImage]?, Error?) -> ()) {
//        let parameters = [
//            "method" : "flickr.photos.getRecent",
//            "api_key" : Environment.shared.apiKey,
//            "format" : Environment.shared.format,
//            "nojsoncallback" : "1",
//            "extras" : "url_q,url_z,owner_name,date_upload"
//        ]
//        
//        getPhotosFromRequest(withParameters: parameters, completion: completion)
//    }
    
    public func getRecentPhotos(with page: Int = 1, completion: @escaping (FlickrPagedImageResult?, Error?) -> ()) {
        let parameters: [String : Any] = [
            "method" : "flickr.photos.getRecent",
            "api_key" : Environment.shared.apiKey,
            "format" : Environment.shared.format,
            "page" : page,
            "nojsoncallback" : 1,
            "extras" : "url_q,url_z,owner_name,date_upload"
        ]
        
        getFlickrPagedImageResult(withParameters: parameters, completion: completion)
    }
    
    public func serachPhoto(withText text: String, completion: @escaping ([FlickrImage]?, Error?) -> ()) {
        let parameters = [
            "method" : "flickr.photos.search",
            "api_key" : Environment.shared.apiKey,
            "text" : text,
            "format" : Environment.shared.format,
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
    private func getPhotosFromRequest(withParameters parameters: [String : String], completion: @escaping ([FlickrImage]?, Error?) -> ()) {
        request(withParameters: parameters) { (response) in
            guard let data = response.data else { return }
            
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
     Gets photo objects from response of api. If photo object not available, return error.
     
     - Parameter parameters: To be sended parameters for flickr api.
     - Parameter completion: Carries photo objects or error object.
     */
    private func getFlickrPagedImageResult(withParameters parameters: [String : Any], completion: @escaping (FlickrPagedImageResult?, Error?) -> ()) {
        request(withParameters: parameters) { (response) in
            guard let data = response.data else { return }
            
            do {
                let flickrImageResult = try JSONDecoder().decode(FlickrImageResult.self, from: data)
                
                guard let flickrPagedImageResult = flickrImageResult.photos else { return }
                
                DispatchQueue.main.async {
                    completion(flickrPagedImageResult, nil)
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
    private func request(withParameters parameters: [String : Any], completion: @escaping (DataResponse<Any>) -> Void) {
        
        Alamofire.request(
            Environment.shared.baseUrl,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            headers: nil
        ).responseJSON(completionHandler: completion)
    }
}
