//
//  CharactersVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 02.09.2021.
//

import Foundation
import UIKit

protocol CharactersVMDelegate: AnyObject{
    func reloadData()
    func startSpinner()
    func stopSpinner()
}

final class CharactersVM{
    weak var delegate: CharactersVMDelegate?
    var selectedCharacter: Characters?
    var characters: [Characters] = []
    var filteredCharacters: [Characters] = []
    var pages: Int?
    var count: Int?
    var images: [String : UIImage] = [:]
    var detailsVC: UIViewController {return UIStoryboard(name: "CharacterDetails", bundle: nil).instantiateViewController(identifier: "CharacterDetailsVC")}
    
    func getData(){
        tellDelegateToStartSpinner()
        getPagesCount {
            self.getJsonData {
                self.characters = self.characters.sorted(by: {$0.id < $1.id})
                self.filteredCharacters = self.characters
                self.tellDelegateToReloadData()
                self.tellDelegateToStopSpinner()
                self.getImages()
            }
        }
    }
    
    func getPagesCount(completion: @escaping () -> Void){
        NetworkManager.shared.downloadData(urlString: RequestURLS.charactersPageURL.rawValue, dataType: CharactersData.self) { result in
            switch result{
            case .success(let array):
                self.pages = array.info.pages
                self.count = array.info.count
                completion()
            case .failure(let error):
                print("\(Errors.dataError.rawValue) \(error)")
            }
        }
    }
    
    func getJsonData(completion: @escaping () -> Void){
        let dispatchGroup = DispatchGroup()
        guard let pages = pages else { return }
        for number in 1...pages{
            dispatchGroup.enter()
            NetworkManager.shared.downloadData(urlString: "\(RequestURLS.charactersPageURL.rawValue)\(number)", dataType: CharactersData.self) { result in
                switch result{
                case .success(let array):
                    let charactersArray = array.results
                    self.characters.append(contentsOf: charactersArray)
                    dispatchGroup.leave()
                case .failure(let error):
                    print("\(Errors.dataError.rawValue) \(error)")
                }
            }
        }
        dispatchGroup.notify(queue: .main){
        completion()
        }
    }
    
    func getImages(){
        guard let count = count else { return }
        for number in 0..<count{
            NetworkManager.shared.getImage(withUrlString: characters[number].image) { image in
                DispatchQueue.main.async{
                self.images.updateValue(image, forKey: self.characters[number].image)
                }
                self.tellDelegateToReloadData()
            }
        }
    }
    
    func sendData(row: Int){
        CharacterDetailsVM.selectedCharacterData = characters[row]
    }
    
    func search(text: String){
        let dispatchGroup = DispatchGroup()
        filteredCharacters = []
        dispatchGroup.enter()
        if text == ""{
            filteredCharacters = characters
        } else {
            for (index, _) in characters.enumerated(){
                if characters[index].name.lowercased().contains(text.lowercased()){
                    filteredCharacters.append(characters[index])
                }
            }
        }
        dispatchGroup.leave()
        dispatchGroup.notify(queue: .main){
            self.tellDelegateToReloadData()
        }
    }
    
//MARK: Delegate functions
    func tellDelegateToStartSpinner(){
        delegate?.startSpinner()
    }
    
    func tellDelegateToStopSpinner(){
        delegate?.stopSpinner()
    }
    
    func tellDelegateToReloadData(){
        delegate?.reloadData()
    }
}




