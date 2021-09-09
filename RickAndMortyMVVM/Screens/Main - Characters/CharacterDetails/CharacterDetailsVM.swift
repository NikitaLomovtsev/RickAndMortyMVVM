//
//  CharacterDetailsVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 03.09.2021.
//

import Foundation
import UIKit

protocol CharacterDetailsVMDelegate: AnyObject{
    func reloadData()
    func startSpinner()
    func stopSpinner()
}

final class CharacterDetailsVM{
    weak var delegate: CharacterDetailsVMDelegate?
    static var selectedCharacterData: Characters?
    var selectedCharacter: Characters? {return CharacterDetailsVM.selectedCharacterData}
    var characterDetails:[CharacterDetails] = []
    var episodesNames: [String] = []
    var snapshotImage: UIImage?
    var infoStaticText = ["Species", "Gender", "Status"]
    var locationStaticText = ["Location", "Origin"]
    
    
    func getData(){
        tellDelegateToStartSpinner()
        getEpisodesForSelectedCharacter {
            self.generateDataForSelectedCharacter()
            self.tellDelegateToStopSpinner()
            self.tellDelegateToReloadData()
            self.getSnapshotImage()
        }
    }
    
    func getEpisodesForSelectedCharacter(completion: @escaping() -> Void){
        let dispatchGroup = DispatchGroup()
        for element in selectedCharacter!.episode{
            dispatchGroup.enter()
            NetworkManager.shared.downloadData(urlString: element, dataType: Episodes.self) { result in
                switch result{
                case .success(let episode):
                    self.episodesNames.append(episode.name)
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
    
    func generateDataForSelectedCharacter(){
        guard let selectedCharacter = selectedCharacter else { return }
        characterDetails = [
            CharacterDetails(header: "SNAPSHOT", row: [selectedCharacter.image]),
            CharacterDetails(header: "NAME", row: [selectedCharacter.name]),
            CharacterDetails(header: "INFO", row: [selectedCharacter.species, selectedCharacter.gender, selectedCharacter.status]),
            CharacterDetails(header: "LOCATION", row: [selectedCharacter.location.name, selectedCharacter.origin.name]),
            CharacterDetails(header: "EPISODES", row: episodesNames)
        ]
    }
    
    func getSnapshotImage(){
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        guard let selectedCharacter = selectedCharacter else { return }
        NetworkManager.shared.fetchImage(withUrlString: selectedCharacter.image) { image in
            self.snapshotImage = image
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main){
        self.tellDelegateToReloadData()
        }
    }
    
    
//MARK: Delegate functions
    func tellDelegateToReloadData(){
        delegate?.reloadData()
    }
    
    func tellDelegateToStartSpinner(){
        delegate?.startSpinner()
    }
    
    func tellDelegateToStopSpinner(){
        delegate?.stopSpinner()
    }
    
}

