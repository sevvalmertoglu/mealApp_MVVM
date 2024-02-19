//
//  RestaurantCollectionViewCell.swift
//  MealApp
//
//  Created by Şevval Mertoğlu on 11.09.2023.
//

import UIKit
import SDWebImage

class RestaurantCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var ratingView: StampView!
    @IBOutlet private weak var campaignView: StampView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var statusView: StampView!
    @IBOutlet private weak var descriptonLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpUI()
    }

    
    private func setUpUI() {
        containerView.backgroundColor = .white
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 14)
        descriptonLabel.textColor = .gray
        descriptonLabel.font = .systemFont(ofSize: 12)
        bannerImageView.layer.cornerRadius = 25
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 25
    }
    
    func configure(restaurant: Restaurant) {
        titleLabel.text = restaurant.name
        
        prepareBannerImage(with: restaurant.imageUrl)
        prepareRating(rating: restaurant.rating, ratingBackgroundColor: restaurant.ratingBackgroundColor)
        prepareCampaingView(campaingText: restaurant.campaignText)
        prepareStatusView(isClosed: restaurant.closed)
        prepareDescriptionView(restaurant)
        
        
    }
    
    private func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string: imageUrlString) {
            bannerImageView.sd_setImage(with: url)
        }
    }
    
    private func prepareRating(rating: Double?, ratingBackgroundColor: String?) {
        if let rating = rating,
           let backgroundColorString = ratingBackgroundColor {
            ratingView.configure(title: String(rating),
                                 font: .systemFont(ofSize: 14),
                                 backgroundColor: .systemGreen )
            ratingView.isHidden = false
        } else {
            ratingView.isHidden = true
        }
    }
    
    private func prepareCampaingView(campaingText: String?) {
        if let campaingText = campaingText, !campaingText.isEmpty {
            campaignView.configure(title: campaingText, backgroundColor: .orange)
            campaignView.isHidden = false
        } else {
            campaignView.isHidden = true
        }
    }
    
    private func prepareStatusView(isClosed: Bool?) {
        if isClosed ?? false {
            statusView.configure(title: "Kapalı", backgroundColor: .red)
            statusView.isHidden = false
        } else {
            statusView.isHidden = true
        }
    }
    
    private func prepareDescriptionView(_ restaurant: Restaurant) {
        let fontRegular: UIFont = .systemFont(ofSize: 14)
        let fontLight: UIFont = .systemFont(ofSize: 10)
        let bullet: String = " \u{2022} " //nokta şeklinin kodu
        let bulletString = NSMutableAttributedString(string: bullet,
                                           attributes: [NSAttributedString.Key.font : fontLight,
                                                       NSAttributedString.Key.foregroundColor : UIColor.gray])
        if restaurant.closed ?? false {
            let attributedString = NSMutableAttributedString(string: restaurant.workingHours,
                                                   attributes: [NSAttributedString.Key.font : fontRegular])
            attributedString.append(bulletString)
            attributedString.append(NSMutableAttributedString(string: restaurant.kitchen,
                                                              attributes: [NSAttributedString.Key.font : fontRegular]))
            descriptonLabel.attributedText = attributedString
        } else {
            let attributedString = NSMutableAttributedString(string: restaurant.averageDeliveryInterval,
                                                   attributes:[NSAttributedString.Key.font : fontRegular])
            attributedString.append(bulletString)
            attributedString.append(NSMutableAttributedString(string: restaurant.averageDeliveryInterval,
                                                   attributes:[NSAttributedString.Key.font : fontRegular]))
            attributedString.append(bulletString)
            attributedString.append(NSMutableAttributedString(string: restaurant.kitchen,
                                                   attributes:[NSAttributedString.Key.font : fontRegular]))
            descriptonLabel.attributedText = attributedString
            
        }
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}
