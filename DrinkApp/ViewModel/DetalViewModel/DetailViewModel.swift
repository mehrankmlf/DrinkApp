//
//  DetailViewModel.swift
//  DrinkApp
//
//  Created by Mehran on 5/28/1401 AP.
//

import Foundation

typealias BaseDetailViewModel =  DetailViewModelProtocol & UnidirectionalDataFlowType

protocol DetailViewModelProtocol {
    var title : String { get }
    var useCase : DrinkDetailProtocol { get }
    func getDrinkDetail(i: String)
}

final class DetailViewModel : BaseViewModel, BaseDetailViewModel {
    
    typealias InputType = Input
    
    var title: String = "Drink Detail"
    var useCase: DrinkDetailProtocol
    
    // MARK: Input
    enum Input {
        case onAppear(id: String)
    }
    
    func apply(_ input: Input) {
        switch input {
        case .onAppear(let id):
            self.handleState()
            self.getDrinkDetail(i: id)
        }
    }
    
    // MARK: Output
    @Published private(set) var data : DrinkDetail_Response = DrinkDetail_Response()
    @Published var isShowActivity : Bool = false
    
    init(useCase : DrinkDetailProtocol) {
        self.useCase = useCase
    }
    
    func getDrinkDetail(i: String) {
        self.callWithProgress(argument: self.useCase.getDrinkDetailService(i: i)) { [weak self] data in
            guard let data = data,
                  let drinkObject = data.data?.first
            else {return}
            self?.data = drinkObject
        }
    }
}

extension DetailViewModel {
    private func handleState() {
        self.loadinState
            .receive(on: Scheduler.dispatchQueue)
            .sink { state in
                switch state {
                case .loadStart:
                    self.isShowActivity = true
                case .dismissAlert:
                    self.isShowActivity = false
                case .emptyStateHandler:
                    self.isShowActivity = false
                }
            }.store(in: &subscriber)
    }
}
