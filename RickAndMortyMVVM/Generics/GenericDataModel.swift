//
//  GenericDataModel.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 16.09.2021.
//

import Foundation

struct GenericData {
    var header: String
    var row: [Any]
    
    init(header: String, row: [Any]) {
        self.header = header
        self.row = row
    }
}
