//
//  ActivityIndicator.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import UIKit

final class ActivityIndicator: NSObject {
    
    fileprivate static let overlayView: UIView = UIView()
    fileprivate static let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView (style: UIActivityIndicatorView.Style.large)
    
    class var shared : ActivityIndicator{
        struct Static {
            static let instance = ActivityIndicator()
        }
        return Static.instance
    }
    
    fileprivate override init() {
        super.init()
        ActivityIndicator.overlayView.backgroundColor = UIColor.activityIndicatorColor
    }
    
    func showLoadingIndicator() {
        guard let window = UIApplication.shared.windows.first else { return }
        ActivityIndicator.overlayView.frame = window.frame
        ActivityIndicator.activityIndicator.center = window.center
        ActivityIndicator.activityIndicator.startAnimating()
        ActivityIndicator.overlayView.addSubview(ActivityIndicator.activityIndicator)
        window.addSubview(ActivityIndicator.overlayView)
        window.bringSubviewToFront(ActivityIndicator.overlayView)
    }
    
    func hideLoadingIndicator() {
        ActivityIndicator.activityIndicator.stopAnimating()
        ActivityIndicator.overlayView.removeFromSuperview()
    }
}
