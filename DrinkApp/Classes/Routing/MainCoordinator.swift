//
//  MainCoordinator.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import UIKit
import SwiftUI
import Combine

protocol MainViewFactory {
    var mainFactory : MainFactory { get set }
    var detailFactory : DrinkDetailFactory { get set }
}

protocol MainCoordinatorProtocol : Coordinator, MainViewFactory {
    func showMainViewController()
    func showDrinkDetailView(id: String)
    init(_ navigationController: UINavigationController,
         mainFactory : MainFactory,
         detailFactory : DrinkDetailFactory)
}

final class MainCoordinator : MainCoordinatorProtocol {
  
    var finishDelegate: FinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .main }
    var mainFactory: MainFactory
    var detailFactory: DrinkDetailFactory
    private var subscriber = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController,
         mainFactory : MainFactory,
         detailFactory: DrinkDetailFactory) {
        self.navigationController = navigationController
        self.mainFactory = mainFactory
        self.detailFactory = detailFactory
    }
    
    func start() {
        showMainViewController()
    }
    
    func showMainViewController() {
        let vc = self.mainFactory.makeMainViewController(coordinator: self)
        vc.navigateSubject.sink { [weak self] event in
            switch event {
            case .main:
                self?.finish()
            case .detail(data: let data):
                self?.showDrinkDetailView(id: data)
            }
        }.store(in: &subscriber)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDrinkDetailView(id: String) {
        if #available(iOS 13.0, *) {
            var detailView = self.detailFactory.makeDetailView(coordinator: self)
            detailView.id = id
            let hostView = UIHostingController(rootView: detailView)
            navigationController.pushViewController(hostView, animated: true)
        }
    }
}
