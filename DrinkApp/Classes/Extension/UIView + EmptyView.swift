//
//  UIView + EmptyView.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation
import UIKit

enum AssociationPolicy: UInt {
    // raw values map to objc_AssociationPolicy's raw values
    case assign = 0
    case copy = 771
    case copyNonatomic = 3
    case retain = 769
    case retainNonatomic = 1
    
    var objc: objc_AssociationPolicy {
        return objc_AssociationPolicy(rawValue: rawValue)!
    }
}

protocol AssociatedObjects: AnyObject { }

// transparent wrappers
extension AssociatedObjects {
    
    /// wrapper around `objc_getAssociatedObject`
    func ao_get(pkey: UnsafeRawPointer) -> Any? {
        return objc_getAssociatedObject(self, pkey)
    }
    
    /// wrapper around `objc_setAssociatedObject`
    func ao_setOptional(_ value: Any?, pkey: UnsafeRawPointer, policy: AssociationPolicy = .retainNonatomic) {
        guard let value = value else { return }
        objc_setAssociatedObject(self, pkey, value, policy.objc)
    }
    
    /// wrapper around `objc_setAssociatedObject`
    func ao_set(_ value: Any, pkey: UnsafeRawPointer, policy: AssociationPolicy = .retainNonatomic) {
        objc_setAssociatedObject(self, pkey, value, policy.objc)
    }
    
    /// wrapper around 'objc_removeAssociatedObjects'
    func ao_removeAll() {
        objc_removeAssociatedObjects(self)
    }
}

extension NSObject: AssociatedObjects { }


enum ViewAssociatedKeys {
    static var emptyState = "emptyState"
}

extension UIView {
    
    var emptyState: EmptyState! {
        get {
            guard let saved = ao_get(pkey: &ViewAssociatedKeys.emptyState) as? EmptyState else {
                self.emptyState = EmptyState(inView: self)
                return self.emptyState
            }
            return saved
        }
        set { ao_set(newValue ?? EmptyState(inView: self), pkey: &ViewAssociatedKeys.emptyState) }
    }
}
