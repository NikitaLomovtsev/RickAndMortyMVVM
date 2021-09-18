//
//  EpisodeDetailsVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 08.09.2021.
//

import Foundation
import UIKit

final class EpisodeDetailsVM: GenericTableVM{
    
    override var presentationVC: UIViewController { return UIStoryboard(name: "CharacterDetails", bundle: nil).instantiateViewController(identifier: "CharacterDetailsVC") }
    
    static var selectedEpisodeData: Episodes?
    var selectedEpisode: Episodes? { return EpisodeDetailsVM.selectedEpisodeData}
    var episodeDetails: [GenericData] = []
    var characters: [Characters] = []
    var infoStaticText = ["Name", "Air date", "Code"]
    
    override func getData(){
        allowedSelectionSection = 1
        tellDelegateToStartSpinner()
        getCharactersForSelectedEpisode {
            self.generateData()
            self.tellDelegateToStopSpinner()
            self.tellDelegateToReloadData()
            
        }
    }
    
//MARK: Get characters from Json
    func getCharactersForSelectedEpisode(completion: @escaping() -> Void){
        let dispatchGroup = DispatchGroup()
        for element in selectedEpisode!.characters{
            dispatchGroup.enter()
            NetworkManager.shared.downloadData(urlString: element, dataType: Characters.self) { result in
                    self.characters.append(result)
                    dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main){
            completion()
        }
    }
    
//MARK: Generate data to fill the table
    func generateData(){
        guard let selectedEpisode = selectedEpisode else { return }
        data = [
            GenericData(header: "INFO", row: [selectedEpisode.name, selectedEpisode.airDate, selectedEpisode.episode]),
            GenericData(header: "CHARACTERS", row: characters)
        ]
    }
    
//MARK: sendData
    override func sendData(_ data: Any) {
        if let character = data as? Characters {
            CharacterDetailsVM.selectedCharacterData = character
        }
    }
    
}
