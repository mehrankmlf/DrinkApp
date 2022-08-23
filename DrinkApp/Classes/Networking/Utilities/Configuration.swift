//
//  Configuration.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation

enum BaseURLType : ObfuscatorInjector {
    case baseApi
    case staging
    
    var desc : String {
        
        switch self {
        case .baseApi :
            return self.obfuscator.reveal(key: ObfuscatedConstants.obfuscatedDomain)
        case .staging :
            return ""
        }
    }
}

enum VersionType {
    case none
    case v1, v2
    
    var desc : String {
        switch self {
        case .none :
            return ""
        case .v1 :
            return "/v1"
        case .v2 :
            return "/v2"
        }
    }
}



