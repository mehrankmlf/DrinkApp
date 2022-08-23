//
//  BaseResponse.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//


import Foundation

class BaseResponse<T: Decodable>: Decodable {
    //base response handler
    var data: T?
}

extension BaseResponse {
    private enum CodingKeys: String, CodingKey {
        case data = "drinks"
    }
}
