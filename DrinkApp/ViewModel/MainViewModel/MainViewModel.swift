//
//  MainViewModel.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation
import Combine

typealias BaseMainViewModel =  MainViewModelProtocol

protocol MainViewModelProtocol {
    var title : String { get }
    var useCase : DrinkListProtocol { get }
    func getDrinkList(a: String)
}

final class MainViewModel : BaseViewModel, BaseMainViewModel {
    
    var title: String = "Drink List"
    var useCase: DrinkListProtocol

    // MARK: Output
    @Published var drinkList : [DrinkList_Response]?
    
    init(useCase : DrinkListProtocol) {
        self.useCase = useCase
    }
    
    func getDrinkList(a: String) {
        self.callWithProgress(argument: self.useCase.getDrinkListService(a: a)) { [weak self] data in
            guard let data = data else {return}
            self?.drinkList = data.data
        }
    }
}
