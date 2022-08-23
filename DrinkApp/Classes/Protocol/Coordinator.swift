//
//  Coordinator.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import UIKit
import Combine

protocol Coordinator : AnyObject {
    var finishDelegate : FinishDelegate? { get set }
    var navigationController : UINavigationController { get set }
    var childCoordinators : [Coordinator] { get set }
    var type : CoordinatorType { get }
    func start()
    func finish()
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordonator: self)
    }
}

protocol FinishDelegate : AnyObject {
    func coordinatorDidFinish(childCoordonator : Coordinator)
}

enum CoordinatorType {
    case main
}
