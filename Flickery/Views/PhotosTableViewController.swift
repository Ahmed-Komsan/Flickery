//
//  PhotosTableViewController.swift
//  Flickery
//
//  Created by Ahmed Komsan on 7/9/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import UIKit
import SDWebImage

class PhotosTableViewController: UITableViewController, UISearchBarDelegate, PresenterDelegate {

    var searchText : String = ""
    let searchController = UISearchController(searchResultsController: nil)
    var photosPresenter : PhotosPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photosPresenter = PhotosPresenter(delegate: self)
        setupSearchNavigation()
    }

    // MARK: - Helpers
    
    func setupSearchNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Photos"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.photosPresenter.currentCount == 0 {
            tableView.setEmptyView(title: "You don't have any photos to see.", message: "start searching for photos NOW.")
        }else {
            tableView.restore()
        }
        
        if self.photosPresenter.fetchInProgress == false && self.photosPresenter.currentCount == 0 {
            return 0
        }
        return self.photosPresenter.currentCount + 1
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == self.photosPresenter.currentCount - 1 ) {
            self.photosPresenter.fetchPhotos(with: searchText)
        }
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == self.photosPresenter.currentCount) {
            let loadingCell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath)
                as! LoadingTableViewCell
            loadingCell.activityIndicator.startAnimating()
            return loadingCell
        }
        
        let flickrPhotoCell = tableView.dequeueReusableCell(withIdentifier: "FlickrPhotoCell", for: indexPath)
            as! FlickrPhotoTableViewCell

        flickrPhotoCell.nameLabel.text = self.photosPresenter.photo(at: indexPath.row).title
        flickrPhotoCell.flickrImage.sd_setImage(with: self.photosPresenter.photo(at: indexPath.row).photoUrl(), placeholderImage: UIImage(named: "sand-clock") )

        return flickrPhotoCell
    }
    
    // MARK:- PhotosPresenterDelegate
    
    func onFetchCompleted(with newPhotosCount: Int) {
        self.tableView.reloadData()
    }
    
    func onFetchFailed(with reason: String) {
        self.tableView.reloadData()
        self.alert(message: reason)
    }
}

extension PhotosTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            self.searchText = text
        } else {
            self.searchText = ""
        }
    }
    
    
    // MARK: - UISearchResultsUpdating Delegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.photosPresenter.fetchPhotos(with: self.searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchText = ""
        self.photosPresenter.fetchPhotos(with: self.searchText)
    }
}
