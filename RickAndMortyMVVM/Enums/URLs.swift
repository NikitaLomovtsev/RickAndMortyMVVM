//
//  URLs.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 03.09.2021.
//

import Foundation

enum RequestURLS: String{
    case baseURL = "https://rickandmortyapi.com/api/"
    case charactersPageURL = "https://rickandmortyapi.com/api/character?page="
    case episodesPageURL = "https://rickandmortyapi.com/api/episode?page="
    case locationsPageURL = "https://rickandmortyapi.com/api/location?page="
}
