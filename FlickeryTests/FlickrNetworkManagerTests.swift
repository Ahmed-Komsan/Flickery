//
//  FlickrNetworkManagerTests.swift
//  FlickeryTests
//
//  Created by Ahmed Komsan on 7/12/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import XCTest
@testable import Flickery

class FlickrNetworkManagerTests: XCTestCase {
    
    var flickrNetworkManager: FlickrNetworkManager!

    override func setUp() {
        flickrNetworkManager = FlickrNetworkManager()
    }
    
    func testFlickrURLFromParameters(){
        
        let searchMethodKey = "method"
        let searchTextKey = "text"
        let pageKey = "page"
        let searchMethod = "flickr.photos.search"
        let searchText = "Bayern Munich"
        let page = 3
        
        let requestUrl = flickrNetworkManager.flickrURLFromParameters(searchMethod: searchMethod, searchString: searchText, page: page)
        
        XCTAssertNotNil(requestUrl)
        XCTAssertNotNil(requestUrl.query)
        
        XCTAssertTrue(requestUrl.query!.contains(searchMethodKey))
        XCTAssertTrue((requestUrl.query!.contains(searchTextKey)))
        XCTAssertTrue(requestUrl.query!.contains(pageKey))
       
    }
    
    func testSuccessResponse(){
        // inputs
        let searchText = "egypt"
        let currentPage = 3
        let objectsKey = "photos"
        
        
        let promise = expectation(description: "Status code: 200")
        
        
        flickrNetworkManager?.searchFlickr(with: searchText, page: currentPage, searchMethod: Constants.photoSearchMethod, objectsKey: objectsKey){ (result: Result<FlickrPhotos, Error>) in
            
            switch result {
            case .failure(let error):
                XCTFail("error: \(error.localizedDescription)")
            case .success( _):
                promise.fulfill()
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    func testParsingError(){
        // inputs
        let searchText = "egypt"
        let currentPage = 3
        let objectsKey = "wrongKey"
        
        
        let promise = expectation(description: "JSON Parsing Failure")
        
        
        flickrNetworkManager?.searchFlickr(with: searchText, page: currentPage, searchMethod: Constants.photoSearchMethod, objectsKey: objectsKey){ (result: Result<FlickrPhotos, Error>) in
            
            switch result {
            case .failure(_):
                promise.fulfill()
            case .success( _):
                XCTFail()
            }
        }
        
        wait(for: [promise], timeout: 5)
    }
    
    override func tearDown() {
        flickrNetworkManager = nil
    }
    
}
