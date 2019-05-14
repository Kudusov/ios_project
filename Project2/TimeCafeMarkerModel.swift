//
//  TimeCafeMarkerModel.swift
//  Project2
//
//  Created by Kudusov Mahmud on 5/14/19.
//  Copyright © 2019 Mahmud. All rights reserved.
//

import Foundation

class TimeCafeMarkerModel: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var name: String!
    var arrayId: Int!
    var id: Int!

    init(position: CLLocationCoordinate2D, name: String, arrayId: Int, id: Int) {
        self.position = position
        self.name = name
        self.arrayId = arrayId
        self.id = id
    }
}
