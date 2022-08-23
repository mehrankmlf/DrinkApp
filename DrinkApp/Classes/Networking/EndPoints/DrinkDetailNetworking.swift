//
//  MainNetworking.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation

enum DrinkDetailNetworking {
    
    case drinkDetail(i: String)
}

extension DrinkDetailNetworking : TargetType {
    var baseURL: BaseURLType {
        return .baseApi
    }
    
    var version: VersionType {
        return .v1
    }

    var path: RequestType {
        switch self {
        case .drinkDetail(let i):
            return .requestPath(path: "\("/1/lookup.php")\(["i":i].queryString)")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .drinkDetail:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .drinkDetail:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        default :
            return nil
        }
    }
}
