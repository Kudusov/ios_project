//
//  TimeCafeDetailView.swift
//  Project2
//
//  Created by Kudusov Mahmud on 5/15/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit

class TimeCafeDetailView: UIView {

    var lastFeatureView = UIView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setupViews() {
        addSubview(estimatebtn)
        addSubview(separatorLine1)
        addSubview(separatorLine2)
        addSubview(separatorLine3)
        addSubview(separatorLine4)
        addSubview(separatorLine5)
        addSubview(separatorLine6)
        addSubview(separatorLine7)
        addSubview(separatorLine8)
        addSubview(separatorLine9)
        addSubview(separatorLine10)
        addSubview(separatorLine11)
        addSubview(separatorLine12)
        addSubview(featureTitleLabel)
        addSubview(contactTitleLabel)
        addSubview(priceTitleLabel)
        addSubview(timeTitleLabel)
        addSubview(ratingTitleLabel)
        addSubview(ratingLogoImageView)
        addSubview(ratingLabel)
        addSubview(addressTitleLabel)
        addSubview(addressLabel)
        addSubview(addressLogoImageView)
        addSubview(stationLabel)
        addSubview(stationLogoImageView)
        addSubview(distanceLogoImageView)
        addSubview(distanceLabel)
        addSubview(timeLabel)
        addSubview(timeLogoImageView)
        addSubview(priceLabel)
        addSubview(priceLogoImageView)
        addSubview(phoneLogoImageView)
        addSubview(phoneLabel)
        addSubview(webLogoImageView)
        addSubview(webLabel)

    }

    func setupConstraints() {

        separatorLine1.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        separatorLine1.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        separatorLine1.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 42).isActive = true
        separatorLine1.heightAnchor.constraint(equalToConstant: 1).isActive = true

        ratingTitleLabel.leftAnchor.constraint(equalTo: self.separatorLine1.rightAnchor, constant: 0).isActive = true
        ratingTitleLabel.centerYAnchor.constraint(equalTo: separatorLine1.centerYAnchor).isActive = true

        separatorLine4.leftAnchor.constraint(equalTo: self.ratingTitleLabel.rightAnchor).isActive = true
        separatorLine4.centerYAnchor.constraint(equalTo: self.ratingTitleLabel.centerYAnchor).isActive = true
        separatorLine4.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        separatorLine4.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 42).isActive = true
        separatorLine4.heightAnchor.constraint(equalToConstant: 1).isActive = true

        ratingLogoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        ratingLogoImageView.topAnchor.constraint(equalTo: separatorLine1.bottomAnchor, constant: 10).isActive = true
        ratingLogoImageView.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        ratingLogoImageView.widthAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true

        ratingLabel.topAnchor.constraint(equalTo: self.separatorLine1.bottomAnchor, constant: 10).isActive = true
        ratingLabel.leftAnchor.constraint(equalTo: ratingLogoImageView.rightAnchor, constant: 10).isActive = true

        estimatebtn.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 10).isActive = true
        estimatebtn.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true

//        estimatebtn.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        estimatebtn.heightAnchor.constraint(equalToConstant: 25).isActive = true
        estimatebtn.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2).isActive = true

        separatorLine2.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        separatorLine2.topAnchor.constraint(equalTo: self.estimatebtn.bottomAnchor, constant: 15).isActive = true

        separatorLine2.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 35).isActive = true
        separatorLine2.heightAnchor.constraint(equalToConstant: 1).isActive = true

        addressTitleLabel.leftAnchor.constraint(equalTo: self.separatorLine2.rightAnchor, constant: 0).isActive = true
        addressTitleLabel.centerYAnchor.constraint(equalTo: separatorLine2.centerYAnchor).isActive = true

        separatorLine3.leftAnchor.constraint(equalTo: self.addressTitleLabel.rightAnchor).isActive = true
        separatorLine3.centerYAnchor.constraint(equalTo: self.addressTitleLabel.centerYAnchor).isActive = true
        separatorLine3.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        separatorLine3.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 35).isActive = true
        separatorLine3.heightAnchor.constraint(equalToConstant: 1).isActive = true

        addressLogoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        addressLogoImageView.topAnchor.constraint(equalTo: separatorLine2.bottomAnchor, constant: 10).isActive = true
        addressLogoImageView.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        addressLogoImageView.widthAnchor.constraint(equalToConstant: CGFloat(18)).isActive = true

        addressLabel.leftAnchor.constraint(equalTo: addressLogoImageView.rightAnchor, constant: 5).isActive = true
        addressLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        addressLabel.topAnchor.constraint(equalTo: separatorLine2.bottomAnchor, constant: 10).isActive = true

        stationLogoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        stationLogoImageView.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 6).isActive = true
        stationLogoImageView.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        stationLogoImageView.widthAnchor.constraint(equalToConstant: CGFloat(18)).isActive = true

        stationLabel.leftAnchor.constraint(equalTo: stationLogoImageView.rightAnchor, constant: 5).isActive = true
        stationLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        stationLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 6).isActive = true

        distanceLogoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        distanceLogoImageView.topAnchor.constraint(equalTo: stationLabel.bottomAnchor, constant: 6).isActive = true
        distanceLogoImageView.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        distanceLogoImageView.widthAnchor.constraint(equalToConstant: CGFloat(18)).isActive = true

        distanceLabel.leftAnchor.constraint(equalTo: distanceLogoImageView.rightAnchor, constant: 5).isActive = true
        distanceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        distanceLabel.topAnchor.constraint(equalTo: stationLabel.bottomAnchor, constant: 6).isActive = true

        separatorLine5.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        separatorLine5.topAnchor.constraint(equalTo: self.distanceLabel.bottomAnchor, constant: 15).isActive = true
        separatorLine5.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 60).isActive = true
        separatorLine5.heightAnchor.constraint(equalToConstant: 1).isActive = true

        timeTitleLabel.leftAnchor.constraint(equalTo: self.separatorLine5.rightAnchor, constant: 0).isActive = true
        timeTitleLabel.centerYAnchor.constraint(equalTo: separatorLine5.centerYAnchor).isActive = true

        separatorLine6.leftAnchor.constraint(equalTo: self.timeTitleLabel.rightAnchor).isActive = true
        separatorLine6.centerYAnchor.constraint(equalTo: self.timeTitleLabel.centerYAnchor).isActive = true
        separatorLine6.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        separatorLine6.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 60).isActive = true
        separatorLine6.heightAnchor.constraint(equalToConstant: 1).isActive = true

        timeLogoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        timeLogoImageView.topAnchor.constraint(equalTo: timeTitleLabel.bottomAnchor, constant: 10).isActive = true
        timeLogoImageView.heightAnchor.constraint(equalToConstant: CGFloat(18)).isActive = true
        timeLogoImageView.widthAnchor.constraint(equalToConstant: CGFloat(18)).isActive = true

        timeLabel.leftAnchor.constraint(equalTo: timeLogoImageView.rightAnchor, constant: 5).isActive = true
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        timeLabel.topAnchor.constraint(equalTo: timeTitleLabel.bottomAnchor, constant: 10).isActive = true

        separatorLine7.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        separatorLine7.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 15).isActive = true
        separatorLine7.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 30).isActive = true
        separatorLine7.heightAnchor.constraint(equalToConstant: 1).isActive = true

        priceTitleLabel.leftAnchor.constraint(equalTo: self.separatorLine7.rightAnchor, constant: 0).isActive = true
        priceTitleLabel.centerYAnchor.constraint(equalTo: separatorLine7.centerYAnchor).isActive = true

        separatorLine8.leftAnchor.constraint(equalTo: self.priceTitleLabel.rightAnchor).isActive = true
        separatorLine8.centerYAnchor.constraint(equalTo: self.priceTitleLabel.centerYAnchor).isActive = true
        separatorLine8.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        separatorLine8.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 30).isActive = true
        separatorLine8.heightAnchor.constraint(equalToConstant: 1).isActive = true

        priceLogoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        priceLogoImageView.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor, constant: 10).isActive = true
        priceLogoImageView.heightAnchor.constraint(equalToConstant: CGFloat(18)).isActive = true
        priceLogoImageView.widthAnchor.constraint(equalToConstant: CGFloat(18)).isActive = true

        priceLabel.leftAnchor.constraint(equalTo: priceLogoImageView.rightAnchor, constant: 5).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        priceLabel.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor, constant: 10).isActive = true

        separatorLine9.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        separatorLine9.topAnchor.constraint(equalTo: self.priceLabel.bottomAnchor, constant: 15).isActive = true
        separatorLine9.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 48).isActive = true
        separatorLine9.heightAnchor.constraint(equalToConstant: 1).isActive = true

        contactTitleLabel.leftAnchor.constraint(equalTo: self.separatorLine9.rightAnchor, constant: 0).isActive = true
        contactTitleLabel.centerYAnchor.constraint(equalTo: separatorLine9.centerYAnchor).isActive = true

        separatorLine10.leftAnchor.constraint(equalTo: self.contactTitleLabel.rightAnchor).isActive = true
        separatorLine10.centerYAnchor.constraint(equalTo: self.contactTitleLabel.centerYAnchor).isActive = true
        separatorLine10.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        separatorLine10.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 48).isActive = true
        separatorLine10.heightAnchor.constraint(equalToConstant: 1).isActive = true

        phoneLogoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        phoneLogoImageView.topAnchor.constraint(equalTo: contactTitleLabel.bottomAnchor, constant: 6).isActive = true
        phoneLogoImageView.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        phoneLogoImageView.widthAnchor.constraint(equalToConstant: CGFloat(18)).isActive = true

        phoneLabel.leftAnchor.constraint(equalTo: phoneLogoImageView.rightAnchor, constant: 5).isActive = true
        phoneLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        phoneLabel.topAnchor.constraint(equalTo: contactTitleLabel.bottomAnchor, constant: 6).isActive = true

        webLogoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        webLogoImageView.topAnchor.constraint(equalTo: phoneLogoImageView.bottomAnchor, constant: 6).isActive = true
        webLogoImageView.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        webLogoImageView.widthAnchor.constraint(equalToConstant: CGFloat(18)).isActive = true

        webLabel.leftAnchor.constraint(equalTo: webLogoImageView.rightAnchor, constant: 5).isActive = true
        webLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        webLabel.topAnchor.constraint(equalTo: phoneLogoImageView.bottomAnchor, constant: 6).isActive = true

        separatorLine11.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        separatorLine11.topAnchor.constraint(equalTo: self.webLabel.bottomAnchor, constant: 15).isActive = true
        separatorLine11.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 48).isActive = true
        separatorLine11.heightAnchor.constraint(equalToConstant: 1).isActive = true

        featureTitleLabel.leftAnchor.constraint(equalTo: self.separatorLine11.rightAnchor, constant: 0).isActive = true
        featureTitleLabel.centerYAnchor.constraint(equalTo: separatorLine11.centerYAnchor).isActive = true

        separatorLine12.leftAnchor.constraint(equalTo: self.featureTitleLabel.rightAnchor).isActive = true
        separatorLine12.centerYAnchor.constraint(equalTo: self.featureTitleLabel.centerYAnchor).isActive = true
        separatorLine12.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        separatorLine12.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2 - 48).isActive = true
        separatorLine12.heightAnchor.constraint(equalToConstant: 1).isActive = true

    }

    func addFeatures(features: [Feature]) -> UIView {
        var lastView = UIView()
        for (index, feature) in features.enumerated() {
            if index == 0 {
                lastView = addFeature(feature: feature, prevLabelView: featureTitleLabel)
            } else {
                lastView = addFeature(feature: feature, prevLabelView: lastView)
            }
        }
        return lastView
    }

    func addFeature(feature: Feature, prevLabelView: UIView) -> UIView {
        print(feature.description)
        let logoImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: Feature.getFeatureLogoPath(featureType: feature.feature) ?? "icons8-time-64")
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()

        let label: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = feature.description
            label.numberOfLines = 0
            return label
        }()

        addSubview(logoImageView)
        addSubview(label)

        logoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        logoImageView.topAnchor.constraint(equalTo: prevLabelView.bottomAnchor, constant: 6).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: CGFloat(20)).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: CGFloat(18)).isActive = true

        label.leftAnchor.constraint(equalTo: logoImageView.rightAnchor, constant: 5).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: prevLabelView.bottomAnchor, constant: 6).isActive = true

        return label

    }
    static func getSeparatorLine() -> UIView {
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.layer.borderWidth = 0.4
        lineView.layer.borderColor = UIColor(red: 106.0/255.0, green: 106.0/255.0 , blue: 106.0/255.0, alpha: 0.5).cgColor
        return lineView
    }

    var separatorLine1: UIView = getSeparatorLine()
    var separatorLine2: UIView = getSeparatorLine()
    var separatorLine3: UIView = getSeparatorLine()
    var separatorLine4: UIView = getSeparatorLine()
    var separatorLine5: UIView = getSeparatorLine()
    var separatorLine6: UIView = getSeparatorLine()
    var separatorLine7: UIView = getSeparatorLine()
    var separatorLine8: UIView = getSeparatorLine()
    var separatorLine9: UIView = getSeparatorLine()
    var separatorLine10: UIView = getSeparatorLine()
    var separatorLine11: UIView = getSeparatorLine()
    var separatorLine12: UIView = getSeparatorLine()

    var featureTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = UIColor.white
        label.text = "Услуги"
        return label
    }()

    var ratingTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = UIColor.white
        label.text = "Рейтинг"
        return label
    }()

    var ratingLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "icons8-rating-64")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "Рейтинг 2.5 из 5"
        label.textColor = .black
        return label
    }()

    var addressTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = UIColor.white
        label.text = "Адрес"
        return label
    }()

    var addressLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "location_logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Измайловский проспект 75А."
        label.numberOfLines = 0
        return label
    }()

    var stationLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "metro_logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()


    var stationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Бауманская, Третьяковская, Измайловская, Коломенская"
        label.numberOfLines = 0
        return label
    }()

    var distanceLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "distance")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()


    var distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "~5км от вас"
        return label
    }()

    var timeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Часы Работы"
        return label
    }()

    var timeLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "icons8-time-64")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "9:00 - 22:00                                            (пн-пт)\n9:00 - 2:00                                              (сб-вс)"
        label.numberOfLines = 0
        return label
    }()

    var priceTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Цена"
        return label
    }()

    var contactTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Контакты"
        return label
    }()

    var priceLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "price-tag")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1-й час                                                      200р\nCo 2-го часа                                            2р/мин\nСтопчек                                                    500р"
        label.numberOfLines = 0
        return label
    }()

    var estimatebtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.green
        btn.setTitle("Оценить", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 25.0 / 2.0
        return btn
    }()

    var phoneLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "icons8-phone-48")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()


    var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "8 (985) 999-88-77"
        label.numberOfLines = 0
        return label
    }()

    var webLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "language")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()


    var webLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "anticafe.ru"
        label.numberOfLines = 0
        return label
    }()
}
