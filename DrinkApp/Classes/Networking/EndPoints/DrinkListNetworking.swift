//
//  DrinkListNetworking.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation

enum DrinkListNetworking {
    
    case drinkList(a : String)
}

extension DrinkListNetworking : TargetType {
    var baseURL: BaseURLType {
        return .baseApi
    }
    
    var version: VersionType {
        return .v1
    }

    var path: RequestType {
        switch self {
        case .drinkList(let a):
            return .requestPath(path: "\("/1/filter.php")\(["a":a].queryString)")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .drinkList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .drinkList:
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
