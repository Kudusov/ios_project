//
//  TimeCafe.swift
//  Project2
//
//  Created by Kudusov Mahmud on 4/22/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import Foundation

enum FeatureType: String, Codable {
    case playstation = "playstation"
    case board_games = "board_games"
    case rooms = "rooms"
    case ping_pong = "ping_pong"
    case hookah = "hookah"
    case musical_instrument = "musical_instrument"
};



struct Feature: Codable {
    let feature: FeatureType
}

let featureOrder:[Feature] = [Feature(feature: .playstation), Feature(feature: .rooms), Feature(feature: .board_games), Feature(feature: .ping_pong), Feature(feature: .musical_instrument), Feature(feature: .hookah)]

struct TimeCafeJson: Codable {

    let id: Int
    let main_image_url: String
    let name: String
    let rating: Float
    let latitude: Float
    let longtitude: Float
    let distance: Float?
    let price: Float
    let price_type: Int
    let address: String
    let station: String
    let website: String
    let phone_number: String
    let features: [Feature]?

}
