//
//  ViewController.swift
//  MealApp
//
//  Created by Şevval Mertoğlu on 11.09.2023.
//

import UIKit
import CoreApi

extension HomeViewController {
    fileprivate enum Constants {
        static let cellDescriptionViewHeight: CGFloat = 60
        static let cellBannerImageViewAspectRatio: CGFloat = 130/345
        
        static let cellLeftPadding: CGFloat = 15
        static let cellRightPadding: CGFloat = 15
    }
}

class HomeViewController: UIViewController {
    let networkManager: NetworkManager<HomeEndpointItem> = NetworkManager()
    @IBOutlet private weak var restaurantsCollectionView: UICollectionView!
    private var widgets: [Widget] = []
    private var href : String = "page=1"
    private var shouldFetchNextPage: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        fetchWidgets(query: href)
    }
    
    private func prepareCollectionView() {
        restaurantsCollectionView.dataSource = self
        restaurantsCollectionView.delegate = self
        
        restaurantsCollectionView.register(cellType: RestaurantCollectionViewCell.self)
    }
    
    
    private func fetchWidgets(query: String) {
        networkManager.request(endpoint: .homepage(query: query), type: HomeResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                if let widgets = response.widgets {
                    self?.shouldFetchNextPage = !widgets.isEmpty
                    self?.widgets.append(contentsOf: widgets)
                } else {
                    self?.shouldFetchNextPage = false
                }
                self?.href = response.href ?? ""
                self?.restaurantsCollectionView.reloadData()
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    private func calculateCellHeight() -> CGFloat {
        let cellWidth =  restaurantsCollectionView.frame.size.width - (Constants.cellLeftPadding + Constants.cellRightPadding)
        let bannerImageHeight = cellWidth * Constants.cellBannerImageViewAspectRatio
        return Constants.cellDescriptionViewHeight + bannerImageHeight
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        widgets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: RestaurantCollectionViewCell.self, indexPath: indexPath)
        //cell configure
       if let restaurant = widgets[indexPath.item].restaurants?.first {
            cell.configure(restaurant: restaurant)
        }
        
        return cell
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.size.width - (Constants.cellLeftPadding + Constants.cellRightPadding ), height: calculateCellHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: .zero, left: Constants.cellLeftPadding, bottom: .zero, right: Constants.cellRightPadding)
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (widgets.count - 1), shouldFetchNextPage {
            fetchWidgets(query: href)
        }
    }
}
