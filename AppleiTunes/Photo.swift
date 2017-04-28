//
//  Photo.swift
//  AppleiTunes
//
//  Created by vingleo on 17/4/27.
//  Copyright © 2017年 Vingleo. All rights reserved.
//

import Foundation

class Photo {
    let trackName:String
    let remoteURL:URL
    let artistID:String
    let releaseDate:Date
    
    init(trackName:String,artistID:String,remoteURL:URL,releaseDate:Date) {
        self.trackName = trackName
        self.artistID = artistID
        self.remoteURL = remoteURL
        self.releaseDate = releaseDate
    }
    
    
}
