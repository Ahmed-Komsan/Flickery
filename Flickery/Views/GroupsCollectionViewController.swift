//
//  GroupsCollectionViewController.swift
//  Flickery
//
//  Created by Ahmed Komsan on 7/11/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import UIKit
import SDWebImage

class GroupsCollectionViewController: UICollectionViewController, GroupsPresenterDelegate {
    
    // MARK: - Properties
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0,right: 20.0)
    private let itemsPerRow: CGFloat = 2
    
    var searchText : String = ""
    var groupsPresenter : GroupsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.groupsPresenter = GroupsPresenter(delegate: self)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.groupsPresenter.fetchInProgress == false && self.groupsPresenter.currentCount == 0 {
            return 0
        }
        return self.groupsPresenter.currentCount + 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if (indexPath.row == self.groupsPresenter.currentCount) {
            let loadingCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionLoadingCell", for: indexPath)
                as! CollectionLoadingCell
            loadingCell.activityIndicator.startAnimating()
            return loadingCell
        }
        
        
        let flickrGroupCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlickrGroupCell",
                                                      for: indexPath) as! FlickrGroupCell
        flickrGroupCell.backgroundColor = .white
        flickrGroupCell.flickrImage.sd_setImage(with: self.groupsPresenter.group(at: indexPath.row).photoUrl(), placeholderImage: UIImage(named: "sand-clock") )
        flickrGroupCell.nameLabel.text = self.groupsPresenter.group(at: indexPath.row).name
        
        return flickrGroupCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == self.groupsPresenter.currentCount - 1 ) {
            self.groupsPresenter.fetchGroups(with: searchText)
        }
    }
    
    // MARK: GroupsPresenterDelegate
    
    func onFetchCompleted(with newPhotosCount: Int) {
        self.collectionView.reloadData()
    }
    
    func onFetchFailed(with reason: String) {
        self.collectionView.reloadData()
        self.alert(message: reason)
    }
}

// MARK: - Text Field Delegate

extension GroupsCollectionViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.searchText = textField.text ?? ""
        self.groupsPresenter.fetchGroups(with: self.searchText)
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Collection View Flow Layout Delegate

extension GroupsCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
