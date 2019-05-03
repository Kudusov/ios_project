//
//  ViewController.swift
//  Project2
//
//  Created by Kudusov Mahmud on 4/21/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit
import SDWebImage

var baseUrl: String = "http://localhost:5000"
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    private var all_cafes: [TimeCafeJson] = []
    let cellIdentifier = "TimeCafeTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        uploadCafes()
    }

    private func uploadCafes() {
        let session = URLSession.shared
        session.dataTask(with: URL(string: baseUrl + "/api/cafes/")!) { (data, response, error) in
            guard let data = data else {
                print("no data, error: \(error?.localizedDescription ?? "unknown error")")

                return
            }

            let decoder = JSONDecoder()
            guard let timecafes: [TimeCafeJson] = try? decoder.decode([TimeCafeJson].self, from: data) else {
                print("error")

                return
            }

            DispatchQueue.main.async { [weak self] in
                self?.all_cafes = timecafes
                self?.tableView.reloadData()
            }

        }.resume()
 
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return all_cafes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wrapped_cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        guard let cell = wrapped_cell as? TimeCafeTableViewCell else {
            return wrapped_cell
        }
        cell.fillCellFromModel(cafe: all_cafes[indexPath.row])

        let url = URL(string: baseUrl + all_cafes[indexPath.row].main_image_url)!

        cell.mainImage.sd_setImage(with: url, completed: nil)
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        session.dataTask(with: url) { [weak cell] data, res, err in
//            guard err == nil else {
//                return
//            }
//            guard let data = data, let image = UIImage(data: data) else {
//                return
//            }
//            DispatchQueue.main.async {
//                cell?.mainImage?.image = image
//
//            }
//            }.resume()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

