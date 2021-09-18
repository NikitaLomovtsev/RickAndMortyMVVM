//
//  CharactersVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 02.09.2021.
//

import Foundation
import UIKit

final class CharactersVM: GenericTableVM{
    
    override var presentationVC: UIViewController { return UIStoryboard(name: "CharacterDetails", bundle: nil).instantiateViewController(identifier: "CharacterDetailsVC") }
    var characters: [Characters] = []
    var characterData: [GenericData] = []
    var pages: Int?
    
    override func getData(){
        tellDelegateToStartSpinner()
        getPagesCount {
            self.getJsonData {
                self.characters = self.characters.sorted(by: {$0.id < $1.id})
                self.generateCharacterData()
                self.data = self.characterData
                self.tellDelegateToReloadData()
                self.tellDelegateToStopSpinner()
            }
        }
    }

//MARK: Get count of Json pages
    func getPagesCount(completion: @escaping () -> Void){
        NetworkManager.shared.downloadData(urlString: RequestURLS.charactersPageURL.rawValue, dataType: CharactersData.self) { result in
                self.pages = result.info.pages
                completion()
        }
    }
    
//MARK: JsonData for characters
    func getJsonData(completion: @escaping () -> Void){
        let dispatchGroup = DispatchGroup()
        guard let pages = pages else { return }
        for number in 1...pages{
            dispatchGroup.enter()
            NetworkManager.shared.downloadData(urlString: "\(RequestURLS.charactersPageURL.rawValue)\(number)", dataType: CharactersData.self) { result in
                self.characters.append(contentsOf: result.results)
                    dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main){
        completion()
        }
    }
    
    func generateCharacterData(){
        characterData = [
            GenericData(header: "", row: characters),
        ]
    }
    
//MARK: sendData
    override func sendData(_ data: Any){
        if let character = data as? Characters {
            CharacterDetailsVM.selectedCharacterData = character
        }
    }
    
//MARK: Search
    func search(text: String){
        let dispatchGroup = DispatchGroup()
        data[0].row.removeAll()
        dispatchGroup.enter()
        if text == ""{
            data = characterData
        } else {
            for (index, _) in characters.enumerated(){
                if characters[index].name.lowercased().contains(text.lowercased()){
                    data[0].row.append(characters[index])
                }
            }
        }
        dispatchGroup.leave()
        dispatchGroup.notify(queue: .main){
            self.tellDelegateToReloadData()
        }
    }
    
}




