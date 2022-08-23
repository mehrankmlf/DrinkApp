//
//  EmptyStateView.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//


import UIKit
import Combine

enum EmptyStateErrorType {
    case serverError
    case noConnection
    case permisionError(type : PermisionType)
}

enum PermisionType : Int {
    
    case camera = 1
    case contact = 2
    case photoLibrary = 3
    case location = 4
    case photoCamera = 5
    
    var desc: String {
        switch self {
            
        case .camera:
            return "You do not have permission to access the Camera, you can access the application through the device settings, Privacy menu"
        case .contact:
            return "You have not allowed access to Contact, you can access the application through the device settings, under the Privacy menu"
        case .photoLibrary:
            return "You are not allowed to access Photos, you can access the app through the device settings under the Privacy menu"
        case .location:
            return "You are not allowed to access Location, you can access the application through the device settings, under the Privacy menu"
        case .photoCamera:
            return "You are not allowed to access Photo and Camera, you can access the application through the device settings, under the Privacy menu"
        }
    }
}

class EmptyStateView: UIView {
    
    struct ViewModel {
        var title : String?
        var description : String?
    }
    
    public var buttonPressSubject = PassthroughSubject<Void, Never>()
    
    var errorType : EmptyStateErrorType = .serverError {
        didSet {
            self.setStyle()
        }
    }
    
    var viewModel : ViewModel? {
        didSet {
            guard let viewModel = viewModel else {return}
            self.lblDesc.isHidden = false
            self.lblDesc.text = viewModel.title
        }
    }
    
    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var btnFirstAction: UIButton!
    @IBOutlet weak var btnSecondAction: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.btnSecondAction.isHidden = true
    }
    
    static func getView() -> EmptyStateView {
        return Bundle.main.loadNibNamed("EmptyStateView", owner: self, options: nil)?.first as! EmptyStateView
    }
    
    @IBAction func btnFirstAction_Clicked(_ sender: Any) {
        self.buttonPressSubject.send()
    }
    
    @IBAction func btnSecondAction_Clicked(_ sender: Any) {
        //do SomeThing
    }
    
    private func setStyle() {
        switch self.errorType {
        case .serverError:
            self.btnFirstAction.setTitle("try again!", for: .normal)
            self.animate()
        case .permisionError(let type):
            self.lblDesc.text = type.desc
            self.btnFirstAction.setTitle("", for: .normal)
        case .noConnection:
            self.btnFirstAction.setTitle("try again!", for: .normal)
        }
    }
    
    private func animate() {
        self.lblDesc.transform = CGAffineTransform(scaleX: 0.2, y: 2)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [.allowUserInteraction, .curveLinear], animations: {
            self.lblDesc.transform = .identity
        })
        self.alpha = 1
    }
}
