//
//  TimeCafe.swift
//  Project2
//
//  Created by Kudusov Mahmud on 4/22/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import Foundation
// associated value
struct User {
    let username: String
    let email: String

    init(username: String, email: String) {
        self.username = username
        self.email = email
    }
}

enum FeatureType: String, Codable {
    case playstation = "playstation"
    case board_games = "board_games"
    case rooms = "rooms"
    case ping_pong = "ping_pong"
    case hookah = "hookah"
    case musical_instrument = "musical_instrument"
    case wifi = "wifi"
    case tea_and_coffee = "tea_and_coffee"
    case projector = "projector"
    case eat = "eat"
};


struct Feature: Codable {
    let feature: FeatureType
    let description: String

    static func getFeatureLogoPath(featureType: FeatureType) -> String? {
        switch featureType {
        case .playstation:
            return "gamepad"
        case .ping_pong:
            return "ping-pong"
        case .musical_instrument:
            return "acoustic-guitar"
        case .rooms:
            return "rooms"
        case .board_games:
            return "board-games"
        case .hookah:
            return "hookah"
        case .projector:
            return "projector"
        case .tea_and_coffee:
            return "coffee_and_tea"
        case .wifi:
            return "wifi"
        case .eat:
            return "eat"
        default:
            return "gamepad"
        }
    }
    
}

struct Image: Codable {
    let image: String
}

let featureOrder:[Feature] = [Feature(feature: .playstation, description: ""), Feature(feature: .rooms, description: ""), Feature(feature: .board_games, description: ""), Feature(feature: .ping_pong, description: ""), Feature(feature: .musical_instrument, description: ""), Feature(feature: .hookah, description: ""), Feature(feature: .projector, description: ""), Feature(feature: .tea_and_coffee, description: ""), Feature(feature: .wifi, description: ""), Feature(feature: .eat, description: "")]

struct Review: Codable {
    let username: String
    let rating: Float
    let review: String
}

struct TimeCafeJson: Codable {
    let id: Int
    let main_image_url: String
    let name: String
    var rating: Float
    let latitude: Double
    let longtitude: Double
    var distance: Double?
    let price: Float
    let price_type: Int
    let address: String
    let station: String
    let website: String
    let phone_number: String
    let images: [Image]?
    let features: [Feature]?
    let working_time: String
    let extended_price: String
}

struct Price {
    let description: String
    let price: String
    init(description: String, price: String) {
        self.description = description
        self.price = price
    }
}

struct WorkTime {
    let time: String
    let date: String
    init(time: String, date: String) {
        self.time = time
        self.date = date
    }
}

extension TimeCafeJson {
    func getWorkingTimeByDays() -> [WorkTime] {
        if self.working_time == "" {
            return [WorkTime]()
        }
        print(self.working_time)
        let arr = self.working_time.components(separatedBy: "|")

        var times = [WorkTime]()
        var time = ""
        var date = ""
        var index = 0
        for item in arr {
            if item != "" {
                if index % 2 == 0 {
                    time = item
                } else {
                    date = item
                    times.append(WorkTime(time: time, date: date))
                }
                index += 1
            }
        }
        print(times)
        return times
    }

    func getPrices() -> [Price] {
        if self.extended_price == "" {
            return [Price]()
        }
        let arr = self.extended_price.components(separatedBy: "|")

        var prices = [Price]()
        var description = ""
        var price = ""
        var index = 0
        for item in arr {
            if item != "" {
                if index % 2 == 0 {
                    description = item
                } else {
                    price = item
                    prices.append(Price(description: description, price: price))
                }
                index += 1
            }
        }
        return prices
    }

}

class Filter {
    enum SortType {
        case rating
        case distance
        case defaulted
    }

    var sortType: SortType = .defaulted
}

