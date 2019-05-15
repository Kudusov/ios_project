//
//  TimeCafeDetailController.swift
//  Project2
//
//  Created by Kudusov Mahmud on 5/14/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit

import UIKit


class TimeCafeDetailView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setupViews() {
        addSubview(separatorLine1)
        addSubview(separatorLine2)
        addSubview(separatorLine3)
        addSubview(separatorLine4)
        addSubview(separatorLine5)
        addSubview(separatorLine6)
        addSubview(separatorLine7)
        addSubview(separatorLine8)
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

        separatorLine2.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        separatorLine2.topAnchor.constraint(equalTo: self.ratingLabel.bottomAnchor, constant: 15).isActive = true

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



}



class TimeCafeDetailController: UIViewController {
    var cafeView = TimeCafeDetailView(frame: CGRect(x: 0, y: 400, width: 100, height: 100))
    let cellId = "cellId"
    var timeCafeJson: TimeCafeJson!
    let newCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.backgroundColor = UIColor.white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        newCollection.delegate = self
        newCollection.dataSource = self
        newCollection.register(CustomeCell.self, forCellWithReuseIdentifier: cellId)
        self.navigationItem.title = timeCafeJson.name
        self.navigationController!.navigationBar.topItem!.title = ""

        view.addSubview(scrollView)
        setupScrollView()
        scrollView.addSubview(newCollection)
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 1000)
        cafeView.frame = CGRect(x: 0, y: 300, width: view.frame.width, height: view.frame.height - 300)
        fillCafeView()

        scrollView.addSubview(cafeView)
        setupCollection()
    }

    private func fillCafeView() {
        self.cafeView.addressLabel.text = timeCafeJson.address
        self.cafeView.stationLabel.text = timeCafeJson.station

    }
    func setupScrollView() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }

    func setupCollection() {
        newCollection.heightAnchor.constraint(equalToConstant: 260  ).isActive = true
        newCollection.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true

    }
}


extension TimeCafeDetailController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeCafeJson.images!.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newCollection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomeCell
        cell.backgroundColor  = .white
        cell.layer.cornerRadius = 10
        var url: URL!
        if indexPath.row == 0 {
            url = URL(string: baseUrl + timeCafeJson.main_image_url)
        } else {
            url = URL(string: baseUrl + timeCafeJson.images![indexPath.row - 1].image)
        }
        cell.imageView.sd_setImage(with: url, completed: nil)
//        cell.imageView.image = UIImage(named: "local_time")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 250)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVC = TimeCafeImagesController()
        destinationVC.currentIndex = indexPath.row
        destinationVC.imagesCount = 10
        destinationVC.timeCafeJson = timeCafeJson
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}


class CustomeCell: UICollectionViewCell {


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

