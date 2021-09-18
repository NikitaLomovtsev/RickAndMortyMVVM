//
//  NetworkManager.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 02.09.2021.
//

import Foundation
import UIKit

class NetworkManager{
    static let shared = NetworkManager()

    func downloadData<T: Decodable>(urlString: String, dataType: T.Type, completion: @escaping (T) -> Void){
        guard let url = URL(string: urlString) else{return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                do {
                    guard let data = data else {return}
                    let dataArray = try JSONDecoder().decode(dataType, from: data)
                    completion(dataArray)
                }catch{
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}

