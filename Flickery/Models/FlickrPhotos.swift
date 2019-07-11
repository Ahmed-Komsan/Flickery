//
//  FlickrPhotos.swift
//  Flickery
//
//  Created by Ahmed Komsan on 7/10/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import Foundation

struct FlickrPhotos: Codable {
    
    let page: Int
    let pages: Int
    let perpage: Int
    let photo: [Photo]
    let total: String
}
