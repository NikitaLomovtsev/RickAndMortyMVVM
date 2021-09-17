//
//  EpisodeDetailsVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 08.09.2021.
//

import Foundation
import UIKit

final class EpisodeDetailsVM: GenericTableViewModel{
    static var selectedEpisodeData: Episodes?
    var selectedEpisode: Episodes? { return EpisodeDetailsVM.selectedEpisodeData}
    var episodeDetails: [GenericData] = []
    var characters: [Characters] = []
    var infoStaticText = ["Name", "Air date", "Code"]
    var characterDetailsVC: UIViewController { return UIStoryboard(name: "CharacterDetails", bundle: nil).instantiateViewController(identifier: "CharacterDetailsVC")}
    
    
    func getData(){
        tellDelegateToStartSpinner()
        getCharactersForSelectedEpisode {
            self.generateDataForSelectedEpisode()
            self.tellDelegateToStopSpinner()
            self.tellDelegateToReloadData()
        }
    }
    
    func getCharactersForSelectedEpisode(completion: @escaping() -> Void){
        let dispatchGroup = DispatchGroup()
        for element in selectedEpisode!.characters{
            dispatchGroup.enter()
            NetworkManager.shared.downloadData(urlString: element, dataType: Characters.self) { result in
                switch result{
                case .success(let character):
                    self.characters.append(character)
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
    
    func generateDataForSelectedEpisode(){
        guard let selectedEpisode = selectedEpisode else { return }
        episodeDetails = [
            GenericData(header: "INFO", row: [selectedEpisode.name, selectedEpisode.airDate, selectedEpisode.episode]),
            GenericData(header: "CHARACTERS", row: characters)
        ]
    }
    
    func sendData(character: Characters){
        CharacterDetailsVM.selectedCharacterData = character
    }
    
}
