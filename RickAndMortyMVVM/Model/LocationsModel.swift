//
//  LocationsModel.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 08.09.2021.
//

import Foundation

struct LocationsData: Decodable {
    let results: [Locations]
    let info: LocationsInfo
}

struct Locations: Decodable{
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
}

struct LocationsInfo: Decodable{
    let pages: Int
    let count: Int
}

struct AlphabetLocations{
    var header: String
    var row: [Locations]
    init(header: String, row: [Locations]) {
        self.header = header
        self.row = row
    }
}
