//
//  EstimatesController.swift
//  Project2
//
//  Created by qwerty on 5/26/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EstimatesController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableTop: NSLayoutConstraint!
    @IBOutlet weak var labelTop: NSLayoutConstraint!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labelHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!

    var reviews = [Review]()
    var cafeId: Int?

    let cellIdentifier = "EstimateTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        uploadReviews()
    }

    // test with Alamofire
    private func uploadReviews() {
        guard let url = URL(string: baseUrl + "/api/marks/" + String(cafeId!)) else {
            return
        }

        Alamofire.request(url, method: .get, parameters: nil).response { (data) in
            guard let jsonData = data.data else {
                guard let error = data.error else {
                    return
                }
                print(error)
                return
            }

            let decoder = JSONDecoder()
            guard let respRes: [Review] = try? decoder.decode([Review].self, from: jsonData) else {
                print("error")

                return
            }

            DispatchQueue.main.async { [weak self] in
                self?.reviews = respRes
                self?.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wrapped_cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        guard let cell = wrapped_cell as? EstimateTableViewCell else {
            return wrapped_cell
        }
        cell.reviewLabel.text = """
        Lorem ipsum cell.fillCellFromModel(cafe: all_cafes[indexPath.row], currentLocation: self.currentLocation)

                let url = URL(string: baseUrl + all_cafes[indexPath.row].main_image_url)!

        cell.mainImage.sd_setImage(with: url, completed: nil)
        """
        cell.reviewLabel.text = reviews[indexPath.row].review
        cell.nameLabel.text = reviews[indexPath.row].username
        cell.ratingLabel.text = String.localizedStringWithFormat("%.1f", reviews[indexPath.row].rating)
        return cell
    }



}
