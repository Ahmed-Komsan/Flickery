//
//  GroupTests.swift
//  FlickeryTests
//
//  Created by Ahmed Komsan on 7/13/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import XCTest
@testable import Flickery

class GroupTests: XCTestCase {

    func testDecoding() throws {
        
        let sampleResponse =
        """
            {
            "nsid": "1316281@N25",
            "name": "Egypt in Photos",
            "eighteenplus": 0,
            "iconserver": "7515",
            "iconfarm": 8,
            "members": "276",
            "pool_count": "8831",
            "topic_count": "0",
            "privacy": "3"
            }
        """
        
        let jsonData = sampleResponse.data(using: .utf8)!
        let result = try JSONDecoder().decode(Group.self, from: jsonData)
        XCTAssertEqual(result.name, "Egypt in Photos")
        XCTAssertEqual(result.id, "1316281@N25")
    }

}
