//
//  Photo.swift
//  Flickery
//
//  Created by Ahmed Komsan on 7/10/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import UIKit

struct Photo: Codable {

    let id: String
    let secret: String
    let farm: Int
    let server: String
    let title: String
    private let  url : String?
    
    func photoUrl() -> URL? {
        let url = self.url ?? "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
        return URL(string: url)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case secret
        case farm
        case server
        case title
        case url = "url_m"
    }
}
