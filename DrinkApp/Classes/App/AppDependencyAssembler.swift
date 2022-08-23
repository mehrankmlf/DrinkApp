//
//  AppDependencyAssembler.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

fileprivate let sharedDependencyAssembler : AppDependencyAssembler = AppDependencyAssembler()

protocol DependencyAssemblerInjector {
    var dependencyAssembler : AppDependencyAssembler { get }
}

extension DependencyAssemblerInjector {
    var dependencyAssembler : AppDependencyAssembler{
        return sharedDependencyAssembler
    }
}

final class AppDependencyAssembler {
    init() {}
}

extension AppDependencyAssembler : MainFactory {
    func makeMainViewController(coordinator: MainCoordinator) -> MainViewController {
        let vc = MainViewController(viewModel: self.makeMainViewModel(coordinator: coordinator))
        return vc
    }
    
    func makeMainViewModel(coordinator: MainCoordinator) -> MainViewModel {
        let viewModel = MainViewModel(useCase: DrinkList_Request())
        return viewModel
    }
}

extension AppDependencyAssembler : DrinkDetailFactory {
    func makeDetailView(coordinator: MainCoordinator) -> DetailView {
        let view = DetailView(viewModel: self.makeDetailViewModel(coordinator: coordinator))
        return view
    }
    
    func makeDetailViewModel(coordinator: MainCoordinator) -> DetailViewModel {
        let viewModel = DetailViewModel(useCase: DrinkDetail_Request())
       return viewModel
    }
}

