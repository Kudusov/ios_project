//
//  TimeCafe.swift
//  Project2
//
//  Created by Kudusov Mahmud on 4/22/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import Foundation

struct Location {
    var lat: Float
    var lon: Float
}

class TimeCafe {

    init(name: String, rating: Float, lat: Float, lon: Float, price: Float, address: String, station: String, imageURL: String) {
        self.imageURL = imageURL
        self.name = name
        self.rating = rating
        self.latitude = lat
        self.longtitude = lon
        self.price = price
        self.distance = 5.1
        self.address = address
        self.station = station
    }

    func calculateDistance(loc: Location) -> Float {
        // Заглушка
        let result : Float = 5.0
        return result
    }

    var imageURL: String
    var name: String
    var rating: Float
    var latitude: Float
    var longtitude: Float
    var distance: Float
    var price: Float
    var address: String
    var station: String

}

let cafes = [
    TimeCafe(name: "Local Time", rating: 4.1, lat: 10, lon: 10, price: 150, address: "Новорязанская ул., 29, стр. 4", station: "Бауманская", imageURL: "local_time"),
    TimeCafe(name: "Белый лист", rating: 3.9, lat: 10, lon: 10, price: 220, address: "Новорязанская ул., 29, стр. 4", station: "Бауманская", imageURL: "beliy_list" ),
    TimeCafe(name: "Убежище", rating: 4.6, lat: 10, lon: 10, price: 180, address: "Новорязанская ул., 29, стр. 4", station: "Бауманская", imageURL: "ubejishe"),
    TimeCafe(name: "Wooden Door", rating: 4.9, lat: 10, lon: 10, price: 250, address: "Новорязанская ул., 29, строение 4", station: "Бауманская", imageURL: "woodern_door"),
    TimeCafe(name: "ComeIn", rating: 3.0, lat: 10, lon: 10, price: 180, address: "Новорязанская ул., 29, строение 4", station: "Бауманская", imageURL: "local_time"),
    TimeCafe(name: "CheckPoint", rating: 3.7, lat: 10, lon: 10, price: 300, address: "Новорязанская ул., 29, строение 4", station: "Бауманская", imageURL: "local_time"),
    TimeCafe(name: "12 ярдов", rating: 4.5, lat: 10, lon: 10, price: 150, address: "Новорязанская ул., 29, строение 4", station: "Бауманская", imageURL: "local_time"),
    TimeCafe(name: "Happy People", rating: 4.0, lat: 10, lon: 10, price: 190, address: "Новорязанская ул., 29, строение 4", station: "Бауманская", imageURL: "local_time"),
    TimeCafe(name: "Территория общения - Русакова Non Stop", rating: 4.8, lat: 10, lon: 10, price: 240, address: "Новорязанская ул., 29, строение 4", station: "Бауманская", imageURL: "local_time"),
    TimeCafe(name: "Коперник", rating: 3.2, lat: 10, lon: 10, price: 220, address: "Новорязанская ул., 29, строение 4", station: "Бауманская", imageURL: "local_time"),
]
