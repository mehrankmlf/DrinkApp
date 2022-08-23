//
//  MainFactory.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation

protocol MainFactory {
    func makeMainViewController(coordinator : MainCoordinator) -> MainViewController
    func makeMainViewModel(coordinator : MainCoordinator) -> MainViewModel
}
