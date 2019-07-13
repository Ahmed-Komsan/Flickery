//
//  PhotoTests.swift
//  FlickeryTests
//
//  Created by Ahmed Komsan on 7/12/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import XCTest
@testable import Flickery

class PhotoTests: XCTestCase {
    
    func testDecoding() throws {
        
        let sampleResponse =
        """
        {
            "id": "48266948981",
            "owner": "120669447@N03",
            "secret": "2d0b6f0d9c",
            "server": "65535",
            "farm": 66,
            "title": "_AMA0090",
            "ispublic": 1,
            "isfriend": 0,
            "isfamily": 0,
            "url_m": "https://live.staticflickr.com/65535/48266948981_2d0b6f0d9c.jpg",
            "height_m": "333",
            "width_m": "500"
        }
        """
        
        let jsonData = sampleResponse.data(using: .utf8)!
        let result = try JSONDecoder().decode(Photo.self, from: jsonData)
        XCTAssertEqual(result.server, "65535")
    }
    
    func testPhotoUrl() throws {
        
        let sampleResponse =
        """
        {
            "id": "48266948981",
            "owner": "120669447@N03",
            "secret": "2d0b6f0d9c",
            "server": "65535",
            "farm": 66,
            "title": "_AMA0090",
            "ispublic": 1,
            "isfriend": 0,
            "isfamily": 0,
            "url_m": "https://live.staticflickr.com/65535/48266948981_2d0b6f0d9c.jpg",
            "height_m": "333",
            "width_m": "500"
        }
        """
        
        let jsonData = sampleResponse.data(using: .utf8)!
        let result = try JSONDecoder().decode(Photo.self, from: jsonData)
        XCTAssertNotNil(result.photoUrl)
        
    }
    
}
