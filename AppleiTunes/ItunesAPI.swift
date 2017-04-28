//
//  ItunesAPI.swift
//  AppleiTunes
//
//  Created by vingleo on 17/4/20.
//  Copyright © 2017年 Vingleo. All rights reserved.
//  updated for API

import Foundation

enum ItunesError: Error {
    case invalidJSONData
    
}

enum  Method:String {
    case search = "search"
    case lookup = "lookup"
}

struct ItunesAPI {
    private static let baseURLString = "https://itunes.apple.com/search"
    private static let apiKey = ""
    
    private static let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    
    
    static var searchPhotosURL:URL {
        return itunesURL(method: .search, parameters: ["limit":"10"])
    }
    
    
    
    static func photos(fromJSON data:Data) -> PhotosResult {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard
            let jsonDictionary = jsonObject as? [AnyHashable:Any],
            //let feed = jsonDictionary["results"] as? [String:Any],
                let entryArray = jsonDictionary["results"] as? [[String:Any]] else {
                    // The JSON structure doesn't match our expections
                    return .failure(ItunesError.invalidJSONData)
            }
            
            print(entryArray)
            
            var finalPhotos = [Photo]()
            for entryJSON in entryArray {
                if let photo = photo(fromJson: entryJSON) {
                    finalPhotos.append(photo)
                }
            }
            if finalPhotos.isEmpty && !entryArray.isEmpty {
                // We weren't able to parse any of the photos
                // Maybe the JSON format for photos has changed
                return .failure(ItunesError.invalidJSONData)
            }
            return .success(finalPhotos)
        } catch let error {
            return .failure(error)
        }
    }
    
    private static func photo(fromJson json: [String : Any]) -> Photo? {
        guard
            let artistID = json["artistID"] as? String,
            let trackName = json["trackName"] as? String,
            let releaseDate = json["releaseDate"] as? String,
            let remoteURLString = json["artworkUrl100"] as? String,
            let url = URL(string: remoteURLString),
            let dateTaken = dateFormatter.date(from: releaseDate) else {
            
            //Don't have enough information to construct a Photo
            return nil
        }
            return Photo(trackName: trackName, artistID: artistID, remoteURL: url, releaseDate: dateTaken)
        
    }
    
    
    private static func itunesURL(method:Method,parameters:[String:String]?) -> URL {
        var components = URLComponents(string: baseURLString)!
        var queryItems = [URLQueryItem]()
        
        
        let baseParams = [
            "method":method.rawValue,
            "term":"jack+johnson",
            "country":"us",
            "media":"music"
        ]
        
        
        for (key,value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key,value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        return components.url!
        
    }
    
    
}

