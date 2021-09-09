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
    
    var imageCache = NSCache<NSString, UIImage>()
    
    func downloadData<T: Decodable>(urlString: String, dataType: T.Type, completion: @escaping (Result<T, Error>) -> Void){
        guard let url = URL(string: urlString) else{return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                do {
                    guard let data = data else {return}
                    let charactersArray = try JSONDecoder().decode(dataType, from: data)
                    completion(.success(charactersArray))
                }catch{
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
    
    
    func fetchImage(withUrlString urlString: String, completion: @escaping(UIImage) -> Void) {
        if let cachedImage = imageCache.object(forKey: urlString as NSString){
            completion(cachedImage)
        } else {
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if error == nil {
                    guard let data = data else {return}
                    guard let image = UIImage(data: data) else {return}
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                    completion(image)
                }else {
                    guard let error = error else {return}
                    print(error)
                }
            }.resume()
        }
    }
    
//MARK: TEST
    func getImage(withUrlString urlString: String, completion: @escaping(UIImage) -> Void) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil {
                guard let data = data else {return}
                guard let image = UIImage(data: data) else {return}
                completion(image)
            }else {
                guard let error = error else {return}
                print(error)
            }
        }.resume()
    }
}

