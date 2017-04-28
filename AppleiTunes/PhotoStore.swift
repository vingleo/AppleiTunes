//
//  PhotoStore.swift
//  AppleiTunes
//
//  Created by vingleo on 17/4/20.
//  Copyright © 2017年 Vingleo. All rights reserved.
//

import Foundation

enum PhotosResult {
    case success([Photo])
    case failure(Error)
}



class PhotoStore {
    private let session:URLSession = {
        let config = URLSessionConfiguration.ephemeral
        return URLSession(configuration: config)
    }()
    
    private func processPhotoRequest(data:Data?,error:Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return ItunesAPI.photos(fromJSON: jsonData)
    }
    
    
    
    
    func fetchInterestingPhotos(completion: @escaping (PhotosResult) -> Void) {
        let url = ItunesAPI.searchPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data,URLResponse,error) -> Void in
//            if let jsonData = data {
////                if let jsonString = String(data:jsonData,encoding:.utf8) {
////                    print(jsonString)
////                }
//            do {
//                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
//                print(jsonObject)
//            } catch let error {
//                print("Error creating JSON object: \(error)")
//                }
//                
//            } else if let requestError = error {
//                print("Error fetching search photos:\(requestError)")
//            } else {
//                print("Unexpected error with the request")
//            }
            let result = self.processPhotoRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
}
