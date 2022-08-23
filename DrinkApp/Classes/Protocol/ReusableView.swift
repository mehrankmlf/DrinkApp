//
//  ReusableView.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}
