//
//  LoadingView.swift
//  MealApp
//
//  Created by Şevval Mertoğlu on 19.02.2024.
//

import UIKit

class LoadingView: UIView {

    static let shared = LoadingView()

        private let activityIndicator: UIActivityIndicatorView

        private override init(frame: CGRect) {
            activityIndicator = UIActivityIndicatorView(style: .large)
            super.init(frame: frame)
            setupViews()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupViews() {
            addSubview(activityIndicator)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }

        func startLoading() {
            activityIndicator.startAnimating()
            isHidden = false
        }

        func hideLoading() {
            activityIndicator.stopAnimating()
            isHidden = true
        }
    }

    // Yükleme işlemlerini yöneten sınıf
    class LoadingManager {
        static let shared = LoadingManager()

        private init() {}

        func startLoading() {
            LoadingView.shared.startLoading()
        }

        func hideLoading() {
            LoadingView.shared.hideLoading()
        }

}
