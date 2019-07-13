//
//  FlickrPhotosTests.swift
//  FlickeryTests
//
//  Created by Ahmed Komsan on 7/13/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import XCTest
@testable import Flickery

class FlickrPhotosTests: XCTestCase {
    
    func testDecoding() throws {
        
        let sampleResponse =
        """
        {
            "page": 3,
            "pages": 20723,
            "perpage": 20,
            "total": "414441",
            "photo": [
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
              },
              {
                "id": "48266475672",
                "owner": "59762168@N00",
                "secret": "bf2fd95c42",
                "server": "65535",
                "farm": 66,
                "title": "Streetart in Dahab Egypt",
                "ispublic": 1,
                "isfriend": 0,
                "isfamily": 0,
                "url_m": "https://live.staticflickr.com/65535/48266475672_bf2fd95c42.jpg",
                "height_m": "303",
                "width_m": "500"
              }
            ]
          }
        """
        
        let jsonData = sampleResponse.data(using: .utf8)!
        let result = try JSONDecoder().decode(FlickrPhotos.self, from: jsonData)
        XCTAssertEqual(result.pages, 20723)
        XCTAssertEqual(result.photo.count, 2)
    }
    
}
