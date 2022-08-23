//
//  DataFlowType.swift
//  DrinkApp
//
//  Created by Mehran on 5/30/1401 AP.
//

import Foundation

protocol UnidirectionalDataFlowType {
    associatedtype InputType
    
    func apply(_ input: InputType)
}
