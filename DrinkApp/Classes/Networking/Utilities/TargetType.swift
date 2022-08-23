//
//  TargetType.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum RequestType {
    /// A request with no additional data.
    case requestPath(path : String)
    /// A request with query param
    case queryParametrs(query : String)
}

enum Task {
    
    /// A request with no additional data.
    case requestPlain
    
    /// A requests body set with encoded parameters.
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}

protocol TargetType {
    
    /// The target's base `URL`.
    var baseURL: BaseURLType { get }
    
    /// The Version of EndPoints
    var version : VersionType { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: RequestType { get }

    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// The type of HTTP task to be performed.
    var task: Task { get }
    
    /// The headers to be used in the request.
    var headers: [String: String]? { get }    
}
