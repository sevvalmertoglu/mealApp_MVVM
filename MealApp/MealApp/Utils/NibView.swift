//
//  NibView.swift
//  MealApp
//
//  Created by Şevval Mertoğlu on 12.09.2023.
//

import UIKit

class NibView: UIView {
    //Custom view oluşturduğumuzda her zaman init kullanmalıyız
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        fromNib()
    }
    
    //Hangi classtam geliyorsam o classın ismini al String'e çevir, ve o xib'i ayağa kaldır. (zaten class ismi ve xib ismini hep aynı veriyoruz.)
    func fromNib() {
        if let contentView = Bundle.main.loadNibNamed(String(describing: type(of: self)),
                                                      owner: self,
                                                      options: nil)?.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
        }
    }
}
