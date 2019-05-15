//
//  TimeCafeDetailController.swift
//  Project2
//
//  Created by Kudusov Mahmud on 5/14/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit

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
        newCollection.register(TimeCafeDetailRoundedImageCell.self, forCellWithReuseIdentifier: cellId)
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
        let cell = newCollection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TimeCafeDetailRoundedImageCell
        cell.backgroundColor  = .white
        cell.layer.cornerRadius = 10
        var url: URL!
        if indexPath.row == 0 {
            url = URL(string: baseUrl + timeCafeJson.main_image_url)
        } else {
            url = URL(string: baseUrl + timeCafeJson.images![indexPath.row - 1].image)
        }
        cell.imageView.sd_setImage(with: url, completed: nil)
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
