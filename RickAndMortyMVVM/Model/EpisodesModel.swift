//
//  Episode.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 05.09.2021.
//

import Foundation

struct EpisodesData: Decodable {
    let results: [Episodes]
    let info: EpisodesInfo
}

struct Episodes: Decodable{
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
    }
}

struct EpisodesInfo: Decodable{
    let pages: Int
    let count: Int
}
