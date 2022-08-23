//
//  DrinkDetailFactory .swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation

protocol DrinkDetailFactory {
    func makeDetailView(coordinator : MainCoordinator) -> DetailView
    func makeDetailViewModel(coordinator : MainCoordinator) -> DetailViewModel
}
