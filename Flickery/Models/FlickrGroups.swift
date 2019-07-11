//
//  FlickrGroups.swift
//  Flickery
//
//  Created by Ahmed Komsan on 7/11/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import Foundation

struct FlickrGroups: Codable {
    
    let page: Int
    let pages: Int
    let perpage: Int
    let group: [Group]
    let total: String
}
