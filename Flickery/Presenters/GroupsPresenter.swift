//
//  GroupsPresenter.swift
//  Flickery
//
//  Created by Ahmed Komsan on 7/11/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import Foundation


protocol GroupsPresenterDelegate: class {
    func onFetchCompleted(with newPhotosCount: Int)
    func onFetchFailed(with reason: String)
}


class GroupsPresenter {
    
    var networkManager : FlickrNetworkManager?
    private weak var delegate: GroupsPresenterDelegate?
    
    var groups: [Group] = []
    private var currentPage = 1
    private var total = 0
    private var isFetchInProgress = false
    private var currentSearchText = ""
    
    convenience init(delegate: GroupsPresenterDelegate) {
        self.init()
        self.networkManager = FlickrNetworkManager()
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return groups.count
    }
    
    var fetchInProgress: Bool {
        return self.isFetchInProgress
    }
    
    func group(at index: Int) -> Group {
        return groups[index]
    }
    
    func fetchGroups(with searchText: String) {
        
        guard searchText.isEmpty == false else {
            self .resetData(searchText)
            self.delegate?.onFetchCompleted(with: self.groups.count)
            return
        }
        
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        
        if self.currentSearchText != searchText {
            resetData(searchText)
            self.delegate?.onFetchCompleted(with: self.groups.count)
        }
        
        networkManager?.searchFlickr(with: searchText, page: currentPage, searchMethod: Constants.groupSearchMethod, objectsKey: "groups"){ (result: Result<FlickrGroups, Error>) in
            
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    DispatchQueue.main.async {
                        self.delegate?.onFetchFailed(with: error.localizedDescription)
                    }
                }
            case .success(let response):
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    self.total = Int(response.total) ?? 0
                    self.groups.append(contentsOf: response.group)
                    self.delegate?.onFetchCompleted(with: self.groups.count)
                }
            }
        }
        
    }
    
    fileprivate func resetData(_ searchText: String) {
        self.groups.removeAll()
        self.currentPage = 1;
        self.total = 0
        self.currentSearchText = searchText
    }
}

