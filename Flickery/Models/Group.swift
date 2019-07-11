//
//  Group.swift
//  Flickery
//
//  Created by Ahmed Komsan on 7/11/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import Foundation

struct Group: Codable {
    
    let id: String
    let topiccount: String
    let members: String
    let privacy: String
    let iconfarm: Int
    let iconserver: String
    let poolcount: String
    let name: String
    let eighteenplus: Int
    
    func photoUrl() -> URL? {
        let url = "https://farm\(iconfarm).staticflickr.com/\(iconserver)/\(id)).jpg"
        return URL(string: url)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "nsid"
        case topiccount = "topic_count"
        case members
        case privacy
        case iconfarm
        case iconserver
        case poolcount = "pool_count"
        case name
        case eighteenplus
    }
}
