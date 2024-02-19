//
//  UICollectionViewCell+Extension.swift
//  MealApp
//
//  Created by Şevval Mertoğlu on 13.09.2023.
//

import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
