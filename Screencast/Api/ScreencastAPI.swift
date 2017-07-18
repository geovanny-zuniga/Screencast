//
//  ScreencastAPI.swift
//  ScreencastList
//
//  Created by Neil García on 7/13/17.
//  Copyright © 2017 SOIN. All rights reserved.
//

import Foundation
import Moya
import RxSwift

// MARK: - Provider setup
let ScreencastApiProvider = RxMoyaProvider<ScreencastApi>()

private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
    }
}

public enum ScreencastApi{
    case episodeList()
    case login(String, String)
}
// MARK: - Moya target for TMDB API  - WIP
extension ScreencastApi : TargetType{
    
    /// Base URL
    // The base url depend on the webservice method.
    public var baseURL: URL {
        switch self {
        case .episodeList(_):
            return URL(string: Constants.fullURL)!
        case .login(_):
            return URL(string: Constants.fullURLLogin)!
        }
    }
    
    /// Returns the path for each endpoing of the API
    public var path: String {
        switch self {
        case .episodeList(_):
            return "/api/episodes.json"
        case .login(_):
            return "/login"
        
        }
    }
    
    /// Set Methods for each endpoint
    public var method: Moya.Method {
        switch self{
            
        case .episodeList(_):
            return .get
        case .login(_):
            return .post
        }
    }
    
    /// Set parameters for each endpoint
    public var parameters: [String: Any]? {
        switch self {
            
        case .episodeList():
            return [:]
        case .login(let userName, let password):
            return ["username": userName, "password": password]
            
        }
    }
    
    public var task: Task {
        return .request
    }
    
    /// Return sample data for each WS for Unit Testing, TODO:
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
        
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
}

/// Endpoint that will execute before each request
let endpointClosure = { (target: ScreencastApi) -> Endpoint<ScreencastApi> in
    //Migration
    let endpoint = Endpoint<ScreencastApi>(url: url(target), sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters, parameterEncoding : target.parameterEncoding)
    return endpoint
}


/**
 Returns the base URL with the route path of the target
 
 - parameter route: Route of the target
 
 - returns: Complete url with host / target
 */
public func url(_ route: TargetType) -> String {
    //Migration
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}


