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
    
    @IBOutlet private weak var restaurantsCollectionView: UICollectionView!

  
    
    var viewModel: HomeViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
        
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.load()

    }
        
    @objc
    private func pullToRefresh() {
        viewModel.pullToRefresh()
    }
    
    private func calculateCellHeight() -> CGFloat {
        let cellWidth =  restaurantsCollectionView.frame.size.width - (Constants.cellLeftPadding + Constants.cellRightPadding)
        let bannerImageHeight = cellWidth * Constants.cellBannerImageViewAspectRatio
        return Constants.cellDescriptionViewHeight + bannerImageHeight
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: RestaurantCollectionViewCell.self, indexPath: indexPath)
        //cell configure
        if let restaurant = viewModel.restaurant(indexPath.item) {
            cell.configure(restaurant: restaurant)
        }
        
        return cell
    }
    
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = viewModel.calculateCellHeight(collectionViewWidth: Double(collectionView.frame.size.width))
           return .init(width: size.width, height: size.height )
//        .init(width: collectionView.frame.size.width - (Constants.cellLeftPadding + Constants.cellRightPadding ), height: viewModel.calculateCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: .zero, left: Constants.cellLeftPadding, bottom: .zero, right: Constants.cellRightPadding)
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.willDisplay(indexPath.item)
        
        
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func showLoadingView() {
        
    }
    
    func hideLoadingView() {
        
    }
    
    func reloadData() {
        
    }
    
    func endRefreshing() {
        
    }
    
    func prepareCollectionView() {
        restaurantsCollectionView.dataSource = self
        restaurantsCollectionView.delegate = self
        restaurantsCollectionView.register(cellType: RestaurantCollectionViewCell.self)
    }
    
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        restaurantsCollectionView.refreshControl = refreshControl
    }


    
    
}
