//
//  ViewController.swift
//  Project2
//
//  Created by Kudusov Mahmud on 4/21/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit
//import SDWebImage


import CoreLocation
var baseUrl: String = "http://localhost:5000"
class TimeCafesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    private var all_cafes: [TimeCafeJson] = []
    let cellIdentifier = "TimeCafeTableViewCell"
    var newManager = LocationManager(handler: {(location: CLLocation) -> Void in })
    // Координаты центра Москвы
    var currentLocation: CLLocation = CLLocation(latitude: +55.75578600, longitude: +37.61763300)

    override func viewDidLoad() {
        super.viewDidLoad()
        newManager = LocationManager(handler: self.updateTableAfterLocationChanging)
        currentLocation = newManager.getCurrentLocation()


        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        uploadCafes()
    }

    
    // TODO: Повторяющаяся функция в двух контроллерах. Выделить в отдельный класс
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

    func updateTableAfterLocationChanging(_ location: CLLocation) -> Void {
        self.currentLocation = location
        updateTable()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return all_cafes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wrapped_cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        guard let cell = wrapped_cell as? TimeCafeTableViewCell else {
            return wrapped_cell
        }
        cell.fillCellFromModel(cafe: all_cafes[indexPath.row], currentLocation: self.currentLocation)

        let url = URL(string: baseUrl + all_cafes[indexPath.row].main_image_url)!

        cell.mainImage.sd_setImage(with: url, completed: nil)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = TimeCafeDetailController()
        destinationVC.timeCafeJson = all_cafes[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: false)
        navigationController?.pushViewController(destinationVC, animated: true)
    }

    func updateTable() {
        self.tableView.reloadData()
    }
}

