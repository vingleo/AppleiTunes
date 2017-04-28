//
//  PhotosViewController.swift
//  AppleiTunes
//
//  Created by vingleo on 17/4/20.
//  Copyright © 2017年 Vingleo. All rights reserved.
//

import UIKit
class PhotosViewController:UIViewController{
    @IBOutlet var imageView:UIImageView!
    
    var store:PhotoStore!
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchInterestingPhotos {
            (photosResult) -> Void in
            
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
            case let .failure(error):
                print("Error fetching searching photos: \(error)")
            }
        }
    }
    
    
}
