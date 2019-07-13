//
//  PhotosPresenterTests.swift
//  FlickeryTests
//
//  Created by Ahmed Komsan on 7/13/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import XCTest
@testable import Flickery

class PhotosPresenterTests: XCTestCase {
    
    var presenter: PhotosPresenter!
    var mockViewController: MockViewController!

    override func setUp() {
        mockViewController = MockViewController()
        presenter = PhotosPresenter(delegate: mockViewController)
    }
    
    func testFetchPhotosWithEmptyText(){
        
        let searchText = ""
        presenter.fetchPhotos(with: searchText)
        XCTAssertGreaterThan(mockViewController.onFetchCompletedCalls, 0)
    }
    
    func testFetchPhotosWithNewText(){
        
        let searchText = "Egypt"
        presenter.fetchPhotos(with: searchText)
        XCTAssertGreaterThan(mockViewController.onFetchCompletedCalls, 0)
        
    }
    
    func testFetchPhotosWithNewText_DataReseting(){
        
        let searchText = "Egypt"
        presenter.fetchPhotos(with: searchText)
        XCTAssertEqual(presenter.photos.count, 0)
        XCTAssertEqual(presenter.currentCount , 0)
        XCTAssertTrue(presenter.fetchInProgress)
        XCTAssertGreaterThan(mockViewController.onFetchCompletedCalls, 0)
    }

    override func tearDown() {
        mockViewController = nil
        presenter = nil
    }

}
