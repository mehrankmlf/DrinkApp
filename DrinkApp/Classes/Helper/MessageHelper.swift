//
//  MessageHelper.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation

struct MessageHelper {
    
    /// General Message Handler
    struct serverError {
        static let general : String = "Bad Request"
        static let noInternet : String = "Check the Connection"
        static let timeOut : String = "Timeout"
        static let notFound : String = "No Result"
        static let serverError : String = "Internal Server Error"
    }
    
    struct DeviceStatus {
        static let unknownDeviceID : String = "Device ID Not Found"
    }
}

