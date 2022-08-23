//
//  Optional + Extension.swift
//  DrinkApp
//
//  Created by Mehran on 5/28/1401 AP.
//

import Foundation

extension Optional where Wrapped == String {
    func orWhenNilOrEmpty(_ defaultValue: String) -> String {
        switch(self) {
        case .none:
            return defaultValue
        case .some(let value) where value.isEmpty:
            return defaultValue
        case .some(let value):
            return value
        }
    }
}
