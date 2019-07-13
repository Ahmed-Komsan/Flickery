//
//  PhotosPresenter.swift
//  Flickery
//
//  Created by Ahmed Komsan on 7/9/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import Foundation

class PhotosPresenter {
    
    var networkManager : FlickrNetworkManager?
    private weak var delegate: PresenterDelegate?
    
    var photos: [Photo] = []
    private var currentPage = 1
    private var total = 0
    private var isFetchInProgress = false
    private var currentSearchText = ""
    
    convenience init(delegate: PresenterDelegate) {
        self.init()
        self.networkManager = FlickrNetworkManager()
        self.delegate = delegate
    }
    
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return photos.count
    }
    
    var fetchInProgress: Bool {
        return self.isFetchInProgress
    }
    
    func photo(at index: Int) -> Photo {
        return photos[index]
    }
    
    func fetchPhotos(with searchText: String) {
        
        guard searchText.isEmpty == false else {
            self .resetData(searchText)
            self.delegate?.onFetchCompleted(with: self.photos.count)
            return
        }
        
        guard !isFetchInProgress else {
            return
        }
        isFetchInProgress = true
        
        if self.currentSearchText != searchText {
            resetData(searchText)
            self.delegate?.onFetchCompleted(with: self.photos.count)
        }
        
        networkManager?.searchFlickr(with: searchText, page: currentPage, searchMethod: Constants.photoSearchMethod, objectsKey: "photos"){ (result: Result<FlickrPhotos, Error>) in
            
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
                    self.photos.append(contentsOf: response.photo)
                    self.delegate?.onFetchCompleted(with: self.photos.count)
                }
            }
        }
        
    }
    
    fileprivate func resetData(_ searchText: String) {
        self.photos.removeAll()
        self.currentPage = 1;
        self.total = 0
        self.currentSearchText = searchText
    }
}
