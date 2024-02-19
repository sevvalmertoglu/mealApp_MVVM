//
//  StampView.swift
//  MealApp
//
//  Created by Şevval Mertoğlu on 16.09.2023.
//

import UIKit

final class StampView: NibView {
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var stampLabel: UILabel!
    
    func configure(title: String,
                   titleColor: UIColor = .white,
                   font: UIFont? = .systemFont(ofSize: 12),
                   backgroundColor: UIColor = .red,
                   cornerRadius: CGFloat = 5 ) {
        
        contentView.backgroundColor = backgroundColor
        contentView.layer.cornerRadius = cornerRadius
        stampLabel.text = title
        stampLabel.font = font
        stampLabel.textColor = titleColor
        

    }
    
    
    
    
    
}
