//
//  TimeCafeImagesController.swift
//  Project2
//
//  Created by Kudusov Mahmud on 5/14/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit


class TimeCafeImagesController: UIViewController {
    var timeCafeJson: TimeCafeJson!
    let cellId = "cellId"
    var currentIndex = 0
    var imagesCount = 10
    let newCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.backgroundColor = UIColor.white
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isScrollEnabled = true
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        newCollection.delegate = self
        newCollection.dataSource = self
        newCollection.register(CustomeImageCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(newCollection)
        setupCollection()

        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(myHandler))
        swipeUpGesture.direction =  UISwipeGestureRecognizer.Direction.up
        view.addGestureRecognizer(swipeUpGesture)

        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(myHandler))
        swipeDownGesture.direction = UISwipeGestureRecognizer.Direction.down
        view.addGestureRecognizer(swipeDownGesture)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let index = IndexPath.init(item: currentIndex, section: 0)
        self.newCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
    }

    @objc func myHandler(){
        navigationController?.popViewController(animated: true)
    }

    func setupCollection() {
        newCollection.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        newCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive  = true

        newCollection.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        newCollection.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
    }
}

extension TimeCafeImagesController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeCafeJson.images!.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = newCollection.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomeImageCell
        cell.backgroundColor  = .white
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
        return CGSize(width: view.frame.width, height: view.frame.height)
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


class CustomeImageCell: UICollectionViewCell {


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
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
