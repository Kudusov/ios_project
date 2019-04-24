//
//  TimeCafeTableViewCell.swift
//  Project2
//
//  Created by Kudusov Mahmud on 4/21/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit

class TimeCafeTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var destinationLable: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var stationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet var collectionOfFeatureLogos: Array<UIImageView>!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainImage.layer.cornerRadius = 10
        self.mainImage.layer.masksToBounds = true
        self.ratingLabel.layer.cornerRadius = 10
        self.ratingLabel.layer.masksToBounds = true

        self.ratingLabel.backgroundColor = UIColor.init(displayP3Red: 0.3, green: 0.8, blue: 1, alpha: 1)
        self.ratingLabel.textColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func fillCellFromModel(cafe: TimeCafeJson) {
//        collectionOfFeatureLogos[0].image = UIImage(named: "ping-pong")
        self.nameLabel.text = cafe.name
        self.destinationLable.text = String(cafe.distance ?? 5.0) + " км от вас"
        var price_type = " ₽/час"
        if (cafe.price_type == 1) {
            price_type = " ₽/мин"
        }

        var price = String(Int(cafe.price))
        if (cafe.price.truncatingRemainder(dividingBy: 1.0) > 0.001) {
            price = String(cafe.price)
        }

        self.priceLabel.text = price + price_type
        self.ratingLabel.text = String(cafe.rating)
        self.addressLabel.text = cafe.address
        self.stationLabel.text = cafe.station
        addIconToLabel(label: stationLabel, icon: "metro_logo")
        addIconToLabel(label: addressLabel, icon: "location_logo")

        setUpFeatureLogos(features: cafe.features ?? [])
    }

    func getFeatureLogoPath(featureType: FeatureType) -> String? {
        switch featureType {
        case .playstation:
            return "gamepad"
        case .ping_pong:
            return "ping-pong"
        case .musical_instrument:
            return "acoustic-guitar"
        case .rooms:
            return "rooms"
        case .board_games:
            return "board-games"
        case .hookah:
            return "hookah"
        default:
            return nil
        }
    }
    func setUpFeatureLogos(features: [Feature]) {

        var feature_count = 0
        for feature in featureOrder {
            if feature_count == collectionOfFeatureLogos.count {
                break
            }
            if features.contains(where: {$0.feature==feature.feature}) {

                guard let path = getFeatureLogoPath(featureType: feature.feature) else {
                    continue
                }
                collectionOfFeatureLogos[feature_count].image = UIImage(named: path)
                feature_count += 1
            }
        }

        if feature_count != collectionOfFeatureLogos.count {
            for i in feature_count...(collectionOfFeatureLogos.count - 1) {
                collectionOfFeatureLogos[i].isHidden = true
            }
        }

    }
    func addIconToLabel(label: UILabel, icon: String){
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = UIImage(named:icon)

        let imageOffsetY:CGFloat = -5.0;
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 20, height: 18)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let  textAfterIcon = NSMutableAttributedString(string: label.text ?? "")
        completeText.append(textAfterIcon)
        label.attributedText = completeText;

    }
    
}
