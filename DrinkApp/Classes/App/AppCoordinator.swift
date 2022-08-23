//
//  AppCoordinator.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import UIKit

protocol AppCoordinatorProtocol : Coordinator {
    func showMainFlow()
}

class AppCoordinator : AppCoordinatorProtocol, DependencyAssemblerInjector {
     
    weak var finishDelegate : FinishDelegate? = nil
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type : CoordinatorType { .main }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.showMainFlow()
    }
    
    func showMainFlow() {
        let main = MainCoordinator.init(navigationController,
                                        mainFactory: self.dependencyAssembler,
                                        detailFactory: self.dependencyAssembler)
        main.finishDelegate = self
        main.start()
        childCoordinators.append(main)
    }
}

extension AppCoordinator : FinishDelegate {
    
    func coordinatorDidFinish(childCoordonator: Coordinator) {
        
        childCoordinators = childCoordinators.filter({ $0.type != childCoordonator.type })
        
        switch childCoordonator.type {
        case .main:
            navigationController.viewControllers.removeAll()
            // show next flow whenever mainflow finished
        }
    }
}
