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
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainImage.layer.cornerRadius = 10
        self.mainImage.layer.masksToBounds = true
        self.ratingLabel.layer.cornerRadius = 10
        self.ratingLabel.layer.masksToBounds = true

        self.ratingLabel.backgroundColor = UIColor.init(displayP3Red: 0.3, green: 0.8, blue: 1, alpha: 1)
        self.ratingLabel.textColor = .black
        addIconToLabel(label: stationLabel, icon: "kisspng-moscow-metro-rapid-transit-rail-transport-kazan-me-metro-5ac0ae12d624d7.3070506215225769148771")
        addIconToLabel(label: addressLabel, icon: "icons8-marker-50")
//        addPlayIcon()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fillCellFromModel(cafe: TimeCafe) {
//        self.animeImage.image = UIImage(named: titles[id ?? 0].file)
        self.mainImage.image = UIImage(named: cafe.imageURL)
        self.nameLabel.text = cafe.name
        self.destinationLable.text = String(cafe.distance) + " км от вас"
        self.priceLabel.text = String(Int(cafe.price)) + " ₽/час"
        self.ratingLabel.text = String(cafe.rating)
        self.addressLabel.text = cafe.address
        self.stationLabel.text = cafe.station
        addIconToLabel(label: stationLabel, icon: "kisspng-moscow-metro-rapid-transit-rail-transport-kazan-me-metro-5ac0ae12d624d7.3070506215225769148771")
        addIconToLabel(label: addressLabel, icon: "icons8-marker-50")
    }

    func addIconToLabel(label: UILabel, icon: String){
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = UIImage(named:icon)

        //Set bound to reposition
        let imageOffsetY:CGFloat = -5.0;
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 20, height: 18)
        //Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        //Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        //Add image to mutable string
        completeText.append(attachmentString)
        //Add your text to mutable string
        let  textAfterIcon = NSMutableAttributedString(string: label.text ?? "")
        completeText.append(textAfterIcon)
//        label.textAlignment = .center
        label.attributedText = completeText;

    }

    func addSomth() {

        //Create Attachment
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = UIImage(named:"icons8-marker-50")

        //Set bound to reposition
        let imageOffsetY:CGFloat = -5.0;
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 20, height: 20)
        //Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        //Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        //Add image to mutable string
        completeText.append(attachmentString)
        //Add your text to mutable string
        let  textAfterIcon = NSMutableAttributedString(string: "Измайловский пр-т 75а")
        completeText.append(textAfterIcon)
    }
    
}
