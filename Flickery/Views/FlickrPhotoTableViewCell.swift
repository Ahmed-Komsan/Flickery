//
//  FlickrPhotoCell.swift
//  Flickery
//
//  Created by Ahmed Komsan on 7/9/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import UIKit

class FlickrPhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flickrImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
