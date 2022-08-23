//
//  BaseViewController.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import UIKit
import SwiftUI
import Combine

protocol ShowEmptyStateProtocol : AnyObject {
    func showEmptyStateView(title: String?, errorType: EmptyStateErrorType, isShow : Bool)
}

class BaseViewController<ViewModel : StandardBaseViewModel>: UIViewController {
    
    var viewModel : ViewModel
    var subscriber = Set<AnyCancellable>()
    weak var delegate : ShowEmptyStateProtocol?

    init(viewModel : ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("use init() method")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBackground
        self.handleViewState()
    }

    func handleViewState() {
        self.viewModel.loadinState
            .sink { [weak self] state in
                self?.setViewState(state: state)
            }.store(in: &subscriber)
    }
}

extension BaseViewController {
    func setViewState(state : ViewModelStatus) {
        switch state {
        case .loadStart:
            ActivityIndicator.shared.showLoadingIndicator()
        case .dismissAlert:
            ActivityIndicator.shared.hideLoadingIndicator()
        case .emptyStateHandler(let title, let isShow):
            self.delegate?.showEmptyStateView(title: title, errorType: .serverError, isShow: isShow)
        }
    }
}

extension BaseViewController {
    
    func setNavigationvBarHidden() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setClearAppearanceNavigationBar() {
        if #available(iOS 15, *) {
            // It is recommended by apple to set the appearance for the navigation
            // item when configuring the navigation appearance of a specific view controller
            // https://developer.apple.com/forums/thread/683590
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            navigationItem.standardAppearance = navigationBarAppearance
            navigationItem.scrollEdgeAppearance = navigationItem.standardAppearance
        } else {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
        }
    }
    
    func setDefaultAppearanceNavigationBar(with barTintColor: UIColor) {
        if #available(iOS 15, *) {
            // It is recommended by apple to set the appearance for the navigation
            // item when configuring the navigation appearance of a specific view controller
            // https://developer.apple.com/forums/thread/683590
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.backgroundColor = barTintColor
            // This will alter the navigation bar title appearance
            let titleAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
                                  NSAttributedString.Key.foregroundColor: UIColor(red: 254.0/255, green: 168.0/255, blue: 11.0/255, alpha: 1.0)] //alter to fit your needs
            
            navigationBarAppearance.titleTextAttributes = titleAttribute
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.standardAppearance = navigationBarAppearance
            navigationController?.navigationBar.compactAppearance = navigationBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
            UIBarButtonItem.appearance().setTitleTextAttributes(titleAttribute, for: .normal)
                                                                    
        } else {
            navigationController?.navigationBar.barTintColor = barTintColor
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
            navigationController?.navigationBar.shadowImage = nil
        }
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
