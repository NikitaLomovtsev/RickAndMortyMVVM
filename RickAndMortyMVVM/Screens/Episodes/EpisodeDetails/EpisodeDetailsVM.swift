//
//  EpisodeDetailsVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 08.09.2021.
//

import Foundation
import UIKit

protocol EpisodeDetailsVMDelegate: AnyObject{
    func reloadData()
    func startSpinner()
    func stopSpinner()
}

final class EpisodeDetailsVM{
    weak var delegate: EpisodeDetailsVMDelegate?
    static var selectedEpisodeData: Episodes?
    var selectedEpisode: Episodes? { return EpisodeDetailsVM.selectedEpisodeData}
    var episodeDetails: [Seasons] = []
    var characters: [Characters] = []
    var infoStaticText = ["Name", "Air date", "Code"]
    
    
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
            Seasons(header: "INFO", row: [selectedEpisode.name, selectedEpisode.airDate, selectedEpisode.episode]),
            Seasons(header: "CHARACTERS", row: characters)
        ]
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
