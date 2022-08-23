//
//  GradientHelper + Extension.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import UIKit

extension UIView {

    func addGradient(colors: [UIColor], locations: [NSNumber]) {
        addSubview(ViewWithGradient(addTo: self, colors: colors, locations: locations))
    }
    
    func addGradientView(colors:[UIColor], startPoint:CGPoint?, endPoint:CGPoint?){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.name = "Gradient"
        gradient.locations = nil
        gradient.frame = self.bounds
        gradient.startPoint = startPoint == nil ? CGPoint(x: 0, y: 0.5) : startPoint!
        gradient.endPoint = endPoint == nil ? CGPoint(x: 0, y: 0.5) : endPoint!
        gradient.cornerRadius = self.layer.cornerRadius
        gradient.colors = colors.map{ $0.cgColor }
        self.layer.insertSublayer(gradient, at: 0)
    }
}

class ViewWithGradient: UIView {

    private var gradient = CAGradientLayer()

    init(addTo parentView: UIView, colors: [UIColor], locations: [NSNumber]){

        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 2))
        restorationIdentifier = "__ViewWithGradient"

        for subView in parentView.subviews {
            if let subView = subView as? ViewWithGradient {
                if subView.restorationIdentifier == restorationIdentifier {
                    subView.removeFromSuperview()
                    break
                }
            }
        }

        let cgColors = colors.map { (color) -> CGColor in
            return color.cgColor
        }

        gradient.frame = parentView.frame
        gradient.colors = cgColors
        gradient.locations = locations
        backgroundColor = .clear

        parentView.addSubview(self)
        parentView.layer.insertSublayer(gradient, at: 0)
        parentView.backgroundColor = .clear
        autoresizingMask = [.flexibleWidth, .flexibleHeight]

        clipsToBounds = true
        parentView.layer.masksToBounds = true

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if let parentView = superview {
            gradient.frame = parentView.bounds
        }
    }

    override func removeFromSuperview() {
        super.removeFromSuperview()
        gradient.removeFromSuperlayer()
    }
}

