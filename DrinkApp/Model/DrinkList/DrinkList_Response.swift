//
//  DrinkList_Response.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation

struct DrinkList_Response : Decodable {
    
    var strDrink : String?
    var strDrinkThumb : String?
    var idDrink : String?
}

extension DrinkList_Response {
    enum CodingKeys: String, CodingKey {
        case strDrink = "strDrink"
        case strDrinkThumb = "strDrinkThumb"
        case idDrink = "idDrink"
    }
}

extension DrinkList_Response {
    // make image url safe
    func safeImageURL() -> String {
        guard let url = self.strDrinkThumb else {return ""}
        return url.trimmingString()
    }
}


