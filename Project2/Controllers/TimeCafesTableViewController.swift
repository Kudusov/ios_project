//
//  ViewController.swift
//  Project2
//
//  Created by Kudusov Mahmud on 4/21/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

import CoreLocation
var baseUrl: String = "http://localhost:5000"

protocol RatingUpdateProtocol {
    func ratingUpdated()
}

protocol FilterDelegateProtocol {
    func filterUpdated(filter: Filter)
    func filterReseted()
}

class TimeCafesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, RatingUpdateProtocol {

    var searchbar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search"
        return bar
    }()

    var filterBtn: UIButton = {
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "icons8-параметры-сортировки-25"), for: UIControl.State.normal)
        return button
    }()

    @IBOutlet weak var tableView: UITableView!
    private var all_cafes: [TimeCafeJson] = []
    private var cellHeight = 140
    let cellIdentifier = "TimeCafeTableViewCell"
    var newManager = LocationManager(handler: {(location: CLLocation) -> Void in })
    var filter = Filter()
    
    // Координаты центра Москвы
    var currentLocation: CLLocation = CLLocation(latitude: +55.75578600, longitude: +37.61763300)

    func ratingUpdated() {
        print("rating updated")
        uploadCafes2()
    }

    override func viewDidLoad() {
//        AuthBearer.clearUserData()

        super.viewDidLoad()
        self.cellHeight = self.cellHeight + calculateLogoSize() - 30
        searchbar.delegate = self
        newManager = LocationManager(handler: self.updateTableAfterLocationChanging)
        currentLocation = newManager.getCurrentLocation()

        filterBtn.addTarget(self, action: #selector(filterBtnTapHandler(_:)), for: .touchUpInside)

        let barButton = UIBarButtonItem(customView: filterBtn)
        navigationItem.titleView = searchbar
        navigationItem.rightBarButtonItem = barButton
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        uploadCafes2()
    }



    @objc func filterBtnTapHandler(_ sender: UIButton) {
        let destinationVC = FilterViewController(nibName: "FilterViewController", bundle: nil)
        destinationVC.filterDelegate = self
        destinationVC.filter = self.filter
        navigationController?.pushViewController(destinationVC, animated: true)
    }

    // test with Alamofire
    private func uploadCafes2() {
        print("upload cafes")
        guard let url = URL(string: baseUrl + "/api/cafes") else {
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
            guard let timecafes: [TimeCafeJson] = try? decoder.decode([TimeCafeJson].self, from: jsonData) else {
                print("error")

                return
            }

            DispatchQueue.main.async { [weak self] in
                print("tableview update")
                self?.all_cafes = timecafes
                self?.calculateDistance()
                 self?.sortCafes()
                self?.tableView.reloadData()
            }
        }
    }

    // TODO: Повторяющаяся функция в двух контроллерах. Выделить в отдельный класс
    private func uploadCafes(searchByName: String = "") {
        let session = URLSession.shared
        var urlComponents = URLComponents(string: baseUrl + "/api/cafes")!
        if searchByName != "" {
            let searchItem = URLQueryItem(name: "search", value: searchByName)
            urlComponents.queryItems = [searchItem]
        }
        let request = URLRequest(url: urlComponents.url!)
        session.dataTask(with: request) { (data, response, error) in
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
                self?.calculateDistance()
                self?.sortCafes()
                self?.tableView.reloadData()
            }

        }.resume()
 
    }

    func calculateLogoSize() -> Int {
        let maxWidth: Float = 42.0
        let maxLogoCount: Float = 5.0
        let screenWidth = UIScreen.main.bounds.width
        let logoContentSize = screenWidth - 182

        var logoSize = Float(logoContentSize) / Float(maxLogoCount)
        if (logoSize > maxWidth) {
            logoSize = maxWidth
        }

        let logoImageSize = Int(logoSize * 2.5 / 3.5)
        return logoImageSize
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
        return CGFloat(self.cellHeight)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = TimeCafeDetailController()
        destinationVC.timeCafeJson = all_cafes[indexPath.row]
        destinationVC.ratingUpdateDelegate = self
        tableView.deselectRow(at: indexPath, animated: false)
        navigationController?.pushViewController(destinationVC, animated: true)
    }

    func updateTable() {
        self.tableView.reloadData()
    }

    func calculateDistance() {
        for i in 0...(all_cafes.count-1) {
            let cafeLocation = CLLocation(latitude: all_cafes[i].latitude, longitude: all_cafes[i].longtitude)
            let distance: Double = currentLocation.distance(from: cafeLocation)
            all_cafes[i].distance = distance
        }
    }

    func sortCafes() {
        if filter.sortType == .distance {
            self.all_cafes = self.all_cafes.sorted(by: { $0.distance! < $1.distance! })
        } else if filter.sortType == .rating {
            self.all_cafes = self.all_cafes.sorted(by: { $0.rating > $1.rating })
        }

    }
}

extension TimeCafesTableViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        self.uploadCafes(searchByName: searchText)
    }
}

extension TimeCafesTableViewController: FilterDelegateProtocol {
    func filterUpdated(filter: Filter) {
        self.filter = filter
        sortCafes()
        updateTable()
    }

    func filterReseted() {
        filter.sortType = .defaulted
    }

}
