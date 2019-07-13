//
//  FlickrGroupsTests.swift
//  FlickeryTests
//
//  Created by Ahmed Komsan on 7/13/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import XCTest
@testable import Flickery

class FlickrGroupsTests: XCTestCase {

    func testDecoding() throws {
        
        let sampleResponse =
        """
        {
            "page": 1,
            "pages": 100,
            "perpage": 20,
            "total": "1984",
            "group": [
              {
                "nsid": "60871945@N00",
                "name": "Egypt Eclipse 2006",
                "eighteenplus": 0,
                "iconserver": "0",
                "iconfarm": 0,
                "members": "159",
                "pool_count": "291",
                "topic_count": "0",
                "privacy": "3"
              },
              {
                "nsid": "1164318@N20",
                "name": "Egypt Travel packages and Tours with cheap cost",
                "eighteenplus": 0,
                "iconserver": "0",
                "iconfarm": 0,
                "members": "41",
                "pool_count": "194",
                "topic_count": "0",
                "privacy": "3"
              }
            ]
        }
        """
        
        let jsonData = sampleResponse.data(using: .utf8)!
        let result = try JSONDecoder().decode(FlickrGroups.self, from: jsonData)
        XCTAssertEqual(result.pages, 100)
        XCTAssertEqual(result.group.count, 2)
    }

}
