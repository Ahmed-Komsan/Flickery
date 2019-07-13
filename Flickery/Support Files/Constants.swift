//
//  Constants.swift
//  Flickery
//
//  Created by Ahmed Komsan on 7/12/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import Foundation

struct Constants {
    
    static let photoSearchMethod = "flickr.photos.search"
    static let groupSearchMethod = "flickr.groups.search"
    
    struct FlickrURLParams {
        static let APIScheme = "https"
        static let APIHost = "api.flickr.com"
        static let APIPath = "/services/rest"
    }
    
    struct FlickrAPIKeys {
        static let SearchMethod = "method"
        static let APIKey = "api_key"
        static let Extras = "extras"
        static let ResponseFormat = "format"
        static let DisableJSONCallback = "nojsoncallback"
        static let SafeSearch = "safe_search"
        static let PerPage = "per_page"
        static let Text = "text"
        static let Page = "page"
    }
    
    struct FlickrAPIValues {
        static let APIKey = "67ac40e8f2d70f38a4ee9dd473d754cd"
        static let ResponseFormat = "json"
        static let DisableJSONCallback = "1"
        static let MediumURL = "url_m"
        static let SafeSearch = "1"
        static let PerPage = "20"
    }
    
}
