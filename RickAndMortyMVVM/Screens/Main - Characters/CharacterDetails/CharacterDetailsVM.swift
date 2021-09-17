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
    var characterDetails:[GenericData] = []
    var episodes: [Episodes] = []
    var snapshotImage: UIImage?
    var infoStaticText = ["Species", "Gender", "Status"]
    var locationStaticText = ["Location", "Origin"]
    var episodeDetailsVC: UIViewController { return UIStoryboard(name: "EpisodeDetails", bundle: nil).instantiateViewController(identifier: "EpisodeDetailsVC")}
    
    
    func getData(){
        tellDelegateToStartSpinner()
        getEpisodesForSelectedCharacter {
            self.generateDataForSelectedCharacter()
            self.tellDelegateToStopSpinner()
            self.tellDelegateToReloadData()
        }
    }
    
    func getEpisodesForSelectedCharacter(completion: @escaping() -> Void){
        let dispatchGroup = DispatchGroup()
        for element in selectedCharacter!.episode{
            dispatchGroup.enter()
            NetworkManager.shared.downloadData(urlString: element, dataType: Episodes.self) { result in
                switch result{
                case .success(let episode):
                    self.episodes.append(episode)
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
            GenericData(header: "SNAPSHOT", row: [selectedCharacter.image]),
            GenericData(header: "NAME", row: [selectedCharacter.name]),
            GenericData(header: "INFO", row: [selectedCharacter.species, selectedCharacter.gender, selectedCharacter.status]),
            GenericData(header: "LOCATION", row: [selectedCharacter.location.name, selectedCharacter.origin.name]),
            GenericData(header: "EPISODES", row: episodes)
        ]
    }
    
    func sendData(episode: Episodes){
        EpisodeDetailsVM.selectedEpisodeData = episode
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

