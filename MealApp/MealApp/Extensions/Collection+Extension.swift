//
//  Collection+Extension.swift
//  MealApp
//
//  Created by Şevval Mertoğlu on 19.02.2024.
//

import Foundation

public extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
 
