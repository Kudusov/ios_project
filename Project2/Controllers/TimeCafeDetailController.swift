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
    private var myTableView: UITableView!

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
//        makeCall(phoneNumber: "8 (985) 138-64-66")
        
        newCollection.delegate = self
        newCollection.dataSource = self
        newCollection.register(TimeCafeDetailRoundedImageCell.self, forCellWithReuseIdentifier: cellId)
        self.navigationItem.title = timeCafeJson.name
        self.navigationController!.navigationBar.topItem!.title = ""

        view.addSubview(scrollView)

        setupScrollView()
        scrollView.addSubview(newCollection)
        print("height = ")
        print(calculateCollectionViewCellHeight())
        scrollView.contentSize = CGSize(width: view.frame.width, height: 470 + calculateCollectionViewCellHeight() + CGFloat(timeCafeJson.features!.count * 26))
        cafeView.frame = CGRect(x: 0, y: calculateCollectionViewCellHeight() + 20, width: view.frame.width, height: view.frame.height - calculateCollectionViewCellHeight() - 20)

        fillCafeView()


        cafeView.estimatebtn.addTarget(self, action: #selector(estimatebtnDidTap), for: .touchUpInside)
        cafeView.reviewbtn.addTarget(self, action: #selector(reviewbtnDidTap), for: .touchUpInside)
        scrollView.addSubview(cafeView)
        setupCollection()

    }

    @objc func estimatebtnDidTap() {
        let storyB = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyB.instantiateViewController(withIdentifier: "RatingViewController") as! RatingViewController
        secondViewController.cafeId = self.timeCafeJson.id
        self.present(secondViewController, animated: true, completion: nil)
    }

    @objc func reviewbtnDidTap() {
        let storyB = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyB.instantiateViewController(withIdentifier: "EstimatesController") as! EstimatesController
        secondViewController.cafeId = self.timeCafeJson.id
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }

    private func fillCafeView() {
        cafeView.fillFromModel(cafe: timeCafeJson)
    }
    
    func setupScrollView() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }

    private func calculateCollectionViewCellHeight() -> CGFloat {
        var height = view.frame.height / 3
        if height > 250 {
            height = 250
        }
        return height
    }

    private func calculateCollectionViewCellWidth() ->CGFloat {
        var width = view.frame.width
        if width > 350 {
            width = 350
        }
        return width
    }

    func setupCollection() {
        let height = calculateCollectionViewCellHeight()
        newCollection.heightAnchor.constraint(equalToConstant: height).isActive = true
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
        let width = calculateCollectionViewCellWidth()
        let height = calculateCollectionViewCellHeight()

        return CGSize(width: width - 20, height: height - 10)
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

    func openWebPage(urlString: String) {
        if urlString.hasPrefix("https://") || urlString.hasPrefix("http://"){
            let url = URL(string: urlString)!
            if #available(iOS 10, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler:
                    nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }else {
            let correctedURL = "https://\(urlString)"
            let url = URL(string: correctedURL)!
            if #available(iOS 10, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler:
                    nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }

    func makeCall(phoneNumber: String) {

//        let formattedNumber = phoneNumber.components(separatedBy:
//            NSCharacterSet.decimalDigits.inverted).joined(separator: "")
//        print(formattedNumber)
//        let phoneUrl = "tel://\(formattedNumber)"
//        let url:NSURL = NSURL(string: phoneUrl)!
//
//        if #available(iOS 10, *) {
//            UIApplication.shared.open(url as URL, options: [:], completionHandler:
//                nil)
//        } else {
//            UIApplication.shared.openURL(url as URL)
//        }
    }
}
