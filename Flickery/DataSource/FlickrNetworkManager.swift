//
//  FlickrNetworkManager.swift
//  Flickery
//
//  Created by Ahmed Komsan on 7/10/19.
//  Copyright © 2019 akomsan. All rights reserved.
//

import Foundation

import Alamofire

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

class FlickrNetworkManager {
    
    let appAPIKey = "67ac40e8f2d70f38a4ee9dd473d754cd"
    let AppAPISharedSecret = "615d82121e329306"
    
    enum NetworkError: Error {
        case invalidData
        case jsonConversionFailure
        case jsonParsingFailure
        
        var localizedDescription: String {
            switch self {
            case .invalidData:
                return "Invalid Data"
            case .jsonConversionFailure:
                return "JSON Conversion Failure"
            case .jsonParsingFailure:
                return "JSON Parsing Failure"
            }
        }
    }
    
    func searchFlickr<ResponseModel:Codable>(with text : String, page: Int,searchMethod:String,objectsKey:String, completion: @escaping (Result<ResponseModel, Error>) -> Void) {
        AF.request(flickrURLFromParameters(searchMethod: searchMethod, searchString: text, page: page)).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                
                guard let value = value as? [String: Any] else {
                    completion(Result.failure( NetworkError.invalidData))
                    return
                }
                
                guard let responseDictionary = value[objectsKey] as? [String: Any] else {
                    completion(Result.failure( NetworkError.jsonParsingFailure))
                    return
                }
                
                guard let jsonData = try? JSONSerialization.data(withJSONObject: responseDictionary) else {
                    completion(Result.failure( NetworkError.invalidData))
                    return
                }
                
                guard let responseModel = try? JSONDecoder().decode(ResponseModel.self, from: jsonData) else {
                    completion(Result.failure( NetworkError.jsonParsingFailure))
                    return
                }
                completion(Result.success(responseModel))
            case .failure(let error):
                print("Error \(error.localizedDescription)")
                completion(Result.failure(response.error!))
                return
            }
        }
    }
    
    
    // MARK:- Helper
    
    private func flickrURLFromParameters(searchMethod : String, searchString: String, page:Int) -> URL {
    
        // Build base URL
        var components = URLComponents()
        components.scheme = Constants.FlickrURLParams.APIScheme
        components.host = Constants.FlickrURLParams.APIHost
        components.path = Constants.FlickrURLParams.APIPath
        
        // Build query string
        components.queryItems = [URLQueryItem]()
        
        // Query components
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.APIKey, value: Constants.FlickrAPIValues.APIKey));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.SearchMethod, value: searchMethod));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.ResponseFormat, value: Constants.FlickrAPIValues.ResponseFormat));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.Extras, value: Constants.FlickrAPIValues.MediumURL));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.SafeSearch, value: Constants.FlickrAPIValues.SafeSearch));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.DisableJSONCallback, value: Constants.FlickrAPIValues.DisableJSONCallback));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.PerPage, value: Constants.FlickrAPIValues.PerPage));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.Text, value: searchString));
        components.queryItems!.append(URLQueryItem(name: Constants.FlickrAPIKeys.Page, value: String(page)));
        
        return components.url!
    }
    
}
