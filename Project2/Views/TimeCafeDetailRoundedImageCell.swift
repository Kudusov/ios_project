//
//  TimeCafeDetailRoundedImageCell.swift
//  Project2
//
//  Created by Kudusov Mahmud on 5/15/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit

class TimeCafeDetailRoundedImageCell: UICollectionViewCell {


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.backgroundColor = UIColor.white
        return image
    }()

    func  setupView(){
        addSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
