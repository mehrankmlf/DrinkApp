//
//  TextField + Extension.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation
import Combine
import UIKit

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func addRightView(txtField: UITextField, str: String) {
        let rightStr = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height))
        rightStr.text = str + " "
        txtField.rightView = rightStr
        txtField.rightViewMode = .always
    }
}
