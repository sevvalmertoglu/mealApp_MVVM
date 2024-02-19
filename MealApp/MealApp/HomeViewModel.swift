//
//  HomeViewModel.swift
//  MealApp
//
//  Created by Şevval Mertoğlu on 19.02.2024.
//

import Foundation
import CoreApi

extension HomeViewModel {
    fileprivate enum Constants {
        static let cellLeftPadding: Double = 15
        static let cellRighttPadding: Double = 15
        static let firstPageHref: String = "page=1"

    }
}

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    var numberOfItems: Int { get }
    
    func load()
    func restaurant(_ index: Int) -> Restaurant?
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double)
    func pullToRefresh()
    func willDisplay(_ index: Int)
    
}

protocol HomeViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
    func endRefreshing()
    func prepareCollectionView()
    func addRefreshControl()

}

final class HomeViewModel {
    private var widgets: [Widget] = [] //Tüm data işlemleri sadece burada olacak
    let networkManager: NetworkManager<HomeEndpointItem> = NetworkManager()
    weak var delegate: HomeViewModelDelegate?
    private var shouldFetchNextPage: Bool = true
    private var href: String = Constants.firstPageHref

    
    private func fetchWidgets(query: String) {
        delegate?.showLoadingView()
        networkManager.request(endpoint: .homepage(query: query), type: HomeResponse.self) { [weak self] result in
            self?.delegate?.hideLoadingView()
            switch result {
            case .success(let response):
                if let widgets = response.widgets {
                    if query == Constants.firstPageHref {
                        self?.widgets = widgets
                    }else {
                        self?.shouldFetchNextPage = !widgets.isEmpty
                        self?.widgets.append(contentsOf: widgets)
                    }
                } else {
                    self?.shouldFetchNextPage = false
                }
                self?.href = response.href ?? ""
                self?.delegate?.reloadData()
                self?.delegate?.endRefreshing()
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func willDisplay(_ index: Int) {
        if index == (widgets.count - 1), shouldFetchNextPage {
            fetchWidgets(query: href)
        }
    }
    
    func pullToRefresh() {
        href = Constants.firstPageHref
        shouldFetchNextPage = true
        fetchWidgets(query: href)

    }
    
    var numberOfItems: Int {
        0
    }
    
    func load() {
        delegate?.prepareCollectionView()
        addRefreshControl()
        fetchWidgets(query: href)
        
    }
    
    func addRefreshControl() {
        
    }
        
    func restaurant(_ index: Int) -> Restaurant? {
        widgets[index].restaurants?.first
    }
    
    func calculateCellHeight(collectionViewWidth: Double) -> (width: Double, height: Double) {
        (width: 0.0, height: 0.0)
    }
    
    
}
   
