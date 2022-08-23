//
//  BaseViewModel.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import Foundation
import Combine

open class BaseViewModel : ObservableObject, StandardBaseViewModel {
    
    var loadinState = CurrentValueSubject<ViewModelStatus, Never>(.dismissAlert)
    var subscriber = Set<AnyCancellable>()
    // Call service with error handling
    func callWithProgress<ReturnType>(argument: AnyPublisher<ReturnType?, APIError>, callback: @escaping (_ data: ReturnType?) -> Void) {
        self.loadinState.send(.loadStart)
        
        let completionHandler: (Subscribers.Completion<APIError>) -> Void = { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.loadinState.send(.dismissAlert)
                self?.loadinState.send(.emptyStateHandler(title: error.desc, isShow: true))
            case .finished:
                self?.loadinState.send(.dismissAlert)
            }
        }
        
        let resultValueHandler: (ReturnType?) -> Void = { data in
            callback(data)
        }
        
        argument
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .sink(receiveCompletion: completionHandler, receiveValue: resultValueHandler)
            .store(in: &subscriber)
    }
    // Call service without error handling
    func callWithoutProgress<ReturnType>(argument: AnyPublisher<ReturnType?, APIError>, callback: @escaping (_ data: ReturnType?) -> Void) {
        
        let resultValueHandler: (ReturnType?) -> Void = { data in
            callback(data)
        }
        
        argument
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .sink(receiveCompletion: {_ in }, receiveValue: resultValueHandler)
            .store(in: &subscriber)
    }
}
