//
//  CharactersModel.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 02.09.2021.
//

import Foundation

struct CharactersData: Decodable {
    let results: [Characters]
    let info: CharactersInfo
}

struct Characters: Decodable{
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    var image: String
    let location: Location
    let episode: [String]
    let origin: Origin
}

struct CharactersInfo: Decodable{
    let pages: Int
    let count: Int
}

struct Location: Decodable{
    let name: String
}

struct Origin: Decodable{
    let name: String
}




struct CharacterDetails {
    var header: String
    var row: [String]
    init(header: String, row: [String]) {
        self.header = header
        self.row = row
    }
}
