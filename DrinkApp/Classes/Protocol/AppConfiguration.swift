//
//  AppConfiguration.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation

//MARK: - Protocols

// App Configuration Base
protocol AppConfiguration {
    
    var baseURL : BaseURLType { get }
    
    var version : VersionType { get }
    
    func isVPNConnected() -> Bool
    func isJailBrokenDevice() -> Bool
    func enableCertificatePinning() -> Bool
    func displayVersion() -> String
}

// App Configuration Set Base
protocol AppConfigurable {
    static var setAppState : AppConfiguration { get }
}




