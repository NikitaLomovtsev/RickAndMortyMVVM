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
    var characters: [Characters] = []
    var filteredCharacters: [GenericData] = []
    var characterData: [GenericData] = []
    var pages: Int?
    var detailsVC: UIViewController {return UIStoryboard(name: "CharacterDetails", bundle: nil).instantiateViewController(identifier: "CharacterDetailsVC")}
    
    func getData(){
        tellDelegateToStartSpinner()
        getPagesCount {
            self.getJsonData {
                self.characters = self.characters.sorted(by: {$0.id < $1.id})
                self.generateTestData()
                self.filteredCharacters = self.characterData
                self.tellDelegateToReloadData()
                self.tellDelegateToStopSpinner()
            }
        }
    }
    
    func getPagesCount(completion: @escaping () -> Void){
        NetworkManager.shared.downloadData(urlString: RequestURLS.charactersPageURL.rawValue, dataType: CharactersData.self) { result in
            switch result{
            case .success(let array):
                self.pages = array.info.pages
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
    
    func generateTestData(){
        characterData = [
            GenericData(header: "", row: characters),
        ]
    }
    
    func sendData(character: Characters){
        CharacterDetailsVM.selectedCharacterData = character
    }
    
    
    func search(text: String){
        let dispatchGroup = DispatchGroup()
        filteredCharacters[0].row.removeAll()
        dispatchGroup.enter()
        if text == ""{
            filteredCharacters = characterData
        } else {
            for (index, _) in characters.enumerated(){
                if characters[index].name.lowercased().contains(text.lowercased()){
                    filteredCharacters[0].row.append(characters[index])
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




