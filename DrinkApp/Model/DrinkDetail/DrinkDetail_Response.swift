//
//  DrinkDetail_Response.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation

struct DrinkDetail_Response : Decodable {
    
    var strDrink : String?
    var strCategory : String?
    var strAlcoholic : String?
    var strGlass : String?
    
    var strInstructions : String?
    var strInstructionsES : String?
    var strInstructionsDE : String?
    var strInstructionsFR : String?
    var strInstructionsIT : String?
    var strInstructionsZH : String?
    var strInstructionsZH2 : String?
    
    var strDrinkThumb : String?
    
    var strIngredient1 : String?
    var strIngredient2 : String?
    var strIngredient3 : String?
    var strIngredient4 : String?
    var strIngredient5 : String?
    var strIngredient6 : String?
    var strIngredient7 : String?
    var strIngredient8 : String?
    var strIngredient9 : String?
    var strIngredient10 : String?
    var strIngredient11 : String?
    var strIngredient12 : String?
    var strIngredient13 : String?
    var strIngredient14 : String?
    var strIngredient15 : String?
}

extension DrinkDetail_Response {
    enum CodingKeys: String, CodingKey {
        case strDrink = "strDrink"
        case strCategory = "strCategory"
        case strAlcoholic = "strAlcoholic"
        case strGlass = "strGlass"
        case strInstructions = "strInstructions"
        case strInstructionsES = "strInstructionsES"
        case strInstructionsDE = "strInstructionsDE"
        case strInstructionsFR = "strInstructionsFR"
        case strInstructionsIT = "strInstructionsIT"
        case strInstructionsZH = "strInstructionsZH-HANS"
        case strInstructionsZH2 = "strInstructionsZH-HANT"
        case strDrinkThumb = "strDrinkThumb"
        
        case strIngredient1 = "strIngredient1"
        case strIngredient2 = "strIngredient2"
        case strIngredient3 = "strIngredient3"
        case strIngredient4 = "strIngredient4"
        case strIngredient5 = "strIngredient5"
        case strIngredient6 = "strIngredient6"
        case strIngredient7 = "strIngredient7"
        case strIngredient8 = "strIngredient8"
        case strIngredient9 = "strIngredient9"
        case strIngredient10 = "strIngredient10"
        case strIngredient11 = "strIngredient11"
        case strIngredient12 = "strIngredient12"
        case strIngredient13 = "strIngredient13"
        case strIngredient14 = "strIngredient14"
        case strIngredient15 = "strIngredient15"
    }
}

extension DrinkDetail_Response {
    // make image url safe
    func safeImageURL() -> String {
        guard let url = self.strDrinkThumb else {return ""}
        let safeURL = url.trimmingString()
        return safeURL
    }
}

extension DrinkDetail_Response {
    // get all of the instructions
    func getInstructions() -> [String]? {
        let mirrorObject = Mirror(reflecting: self)
        
        var instructionsArray: [String] = []
        for child in mirrorObject.children {
            guard let instructionsKey = child.label else { return []}
            let instructionsValue = child.value as? String
            if instructionsKey.contains("strInstructions"), !String.isNilOrEmpty(string: instructionsValue) {
                instructionsArray.append(instructionsValue!)
            }
        }
        return instructionsArray.compactMap{ $0 }
    }
    // get all of the ingredients
    func getIngredients() -> [String]? {
        let mirrorObject = Mirror(reflecting: self)
        
        var ingredientsArray: [String] = []
        for child in mirrorObject.children {
            guard let ingredientKey = child.label else { return []}
            let ingredientValue = child.value as? String
            if ingredientKey.contains("strIngredient"), !String.isNilOrEmpty(string: ingredientValue) {
                ingredientsArray.append(ingredientValue!)
            }
        }
        return ingredientsArray.compactMap{ $0 }
    }
    
}
