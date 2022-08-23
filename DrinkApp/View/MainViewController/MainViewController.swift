//
//  MainViewController.swift
//  DrinkApp
//
//  Created by Mehran on 5/27/1401 AP.
//

import UIKit
import Combine

final class MainViewController: BaseViewController<MainViewModel> {
    
    var contentView = MainView()
    var navigateSubject = PassthroughSubject<MainViewController.Event, Never>()
    private var dataSource:TableViewCustomDataSource<DrinkList_Response>?
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.delegate = self
        self.setupTableView()
        self.bindViewModel()
        self.callServie()
        contentView.viewContainer.emptyState.delegate = self
        self.setupNavigationBar()
    }
    
    private func setupTableView() {
        contentView.tableView.register(MainTableViewCell.self, forCellReuseIdentifier:  MainTableViewCell.identifier)
    }
    
    private func setupNavigationBar() {
        self.setDefaultAppearanceNavigationBar(with: .darkBackground)
        self.navigationItem.title = viewModel.title
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    private func bindViewModel() {
        viewModel.$drinkList
            .compactMap({ $0 })
            .sink { [weak self] data in
                self?.renderTableViewdataSource(data)
            }.store(in: &subscriber)
    }
    
    private func renderTableViewdataSource(_ itemlists:[DrinkList_Response]) {
        dataSource = .displayData(for: itemlists, withCellidentifier: MainTableViewCell.identifier)
        self.contentView.tableView.dataSource = dataSource
        self.contentView.tableView.delegate = self
        self.contentView.tableView.reloadData()
    }
    
    private func callServie() {
        viewModel.getDrinkList(a: AppConstant.ServiceType.alcoholic)
    }
}

extension MainViewController : EmptyStateDelegate, ShowEmptyStateProtocol {
    func showEmptyStateView(title: String?, errorType: EmptyStateErrorType, isShow: Bool) {
        contentView.viewContainer.emptyState.show(title: title ?? "", errorType: errorType, isShow: isShow)
    }
    
    func emptyStateButtonClicked() {
        self.callServie()
        contentView.viewContainer.emptyState.hide()
    }
}

extension MainViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = self.viewModel.drinkList else {return}
        let indexPathData = data[indexPath.row]
        let id = indexPathData.idDrink.orWhenNilOrEmpty("")
        self.navigateSubject.send(.detail(data: id))
    }
}

extension MainViewController {
    enum Event {
        case main
        case detail(data : String)
    }
}
