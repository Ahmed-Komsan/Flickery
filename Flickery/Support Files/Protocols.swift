//
//  Protocols.swift
//  Flickery
//
//  Created by Ahmed Komsan on 7/13/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import Foundation

protocol PresenterDelegate: class {
    
    func onFetchCompleted(with newCount: Int)
    func onFetchFailed(with reason: String)
}

