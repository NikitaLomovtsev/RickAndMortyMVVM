//
//  Errors.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 07.09.2021.
//

import Foundation

enum Errors: String{
    case dataError = "Error received requesting data: "
    case shortPassword = "Password must be atleast 8 or more characters"
    case emptyUsernameOrPassword = "Username and/or Password fields should not be empty"
}


