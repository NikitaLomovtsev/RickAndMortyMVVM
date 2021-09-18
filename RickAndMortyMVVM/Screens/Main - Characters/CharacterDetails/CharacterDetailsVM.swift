//
//  CharacterDetailsVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 03.09.2021.
//

import Foundation
import UIKit

final class CharacterDetailsVM: GenericTableVM{
    
    override var presentationVC: UIViewController { return UIStoryboard(name: "EpisodeDetails", bundle: nil).instantiateViewController(identifier: "EpisodeDetailsVC") }
    
    static var selectedCharacterData: Characters?
    var selectedCharacter: Characters? {return CharacterDetailsVM.selectedCharacterData}
    var episodes: [Episodes] = []
    var snapshotImage: UIImage?
    var infoStaticText = ["Species", "Gender", "Status"]
    var locationStaticText = ["Location", "Origin"]
    
    
    override func getData(){
        allowedSelectionSection = 4
        tellDelegateToStartSpinner()
        getEpisodesForSelectedCharacter {
            self.generateData()
            self.tellDelegateToStopSpinner()
            self.tellDelegateToReloadData()
        }
    }
    
//MARK: Get episodes from Json
    func getEpisodesForSelectedCharacter(completion: @escaping() -> Void){
        let dispatchGroup = DispatchGroup()
        for element in selectedCharacter!.episode{
            dispatchGroup.enter()
            NetworkManager.shared.downloadData(urlString: element, dataType: Episodes.self) { result in
                    self.episodes.append(result)
                    dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main){
            completion()
        }
    }
    
//MARK: Generate data to fill the table
    func generateData(){
        guard let selectedCharacter = selectedCharacter else { return }
        data = [
            GenericData(header: "SNAPSHOT", row: [selectedCharacter.image]),
            GenericData(header: "NAME", row: [selectedCharacter.name]),
            GenericData(header: "INFO", row: [selectedCharacter.species, selectedCharacter.gender, selectedCharacter.status]),
            GenericData(header: "LOCATION", row: [selectedCharacter.location.name, selectedCharacter.origin.name]),
            GenericData(header: "EPISODES", row: episodes)
        ]
    }

//MARK: sendData
    override func sendData(_ data: Any) {
        if let episode = data as? Episodes {
            EpisodeDetailsVM.selectedEpisodeData = episode
        }
    }
    
}

