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
    let artistId:String
    let releaseDate:Date
    
    init(trackName:String,artistId:String,remoteURL:URL ,releaseDate:Date)
    {
        self.trackName = trackName
        self.artistId = artistId
        self.remoteURL = remoteURL
        self.releaseDate = releaseDate
    }
    
    
}
