//
//  MockViewController.swift
//  FlickeryTests
//
//  Created by Ahmed Komsan on 7/13/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import Foundation
@testable import Flickery

class MockViewController: PresenterDelegate {
    
    var onFetchCompletedCalls = 0
    var onFetchFailedCalls = 0
    
    // MARK:- PhotosPresenterDelegate
    
    func onFetchCompleted(with newPhotosCount: Int) {
        onFetchCompletedCalls += 1
    }
    
    func onFetchFailed(with reason: String) {
        onFetchFailedCalls += 1
    }
    
}
