//
//  EpisodesVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 06.09.2021.
//

import Foundation
import UIKit

protocol EpisodesVMDelegate: AnyObject{
    func reloadData()
    func startSpinner()
    func stopSpinner()
}

final class EpisodesVM{
    
    weak var delegate: EpisodesVMDelegate?
    static var selectedEpisode: Episodes?
    var pages: Int?
    var episodes:[Episodes] = []
    var episodesWithSections: [GenericData] = []
    var seasons = 1 //temporary value, will calculate later
    var detailsVC: UIViewController { return UIStoryboard(name: "EpisodeDetails", bundle: nil).instantiateViewController(identifier: "EpisodeDetailsVC")}
    
    
    
    func getData(){
        tellDelegateToStartSpinner()
        getPagesCount {
            self.getJsonData {
                self.episodes = self.episodes.sorted(by: {$0.id < $1.id})
                self.countOfSeasons()
                self.episodesWithSectionsCreating()
                self.tellDelegateToStopSpinner()
                self.tellDelegateToReloadData()
            }
        }
    }
    
    func getPagesCount(completion: @escaping () -> Void){
        NetworkManager.shared.downloadData(urlString: RequestURLS.episodesPageURL.rawValue, dataType: EpisodesData.self) { result in
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
            NetworkManager.shared.downloadData(urlString: "\(RequestURLS.episodesPageURL.rawValue)\(number)", dataType: EpisodesData.self) { result in
                switch result{
                case .success(let array):
                    let episodesArray = array.results
                    self.episodes.append(contentsOf: episodesArray)
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

    //Calculate the number of seasons
    func countOfSeasons(){
        var counter = 1
        while true{
            if seasons < 10{
            counter = self.episodes.filter({$0.episode.contains("S0\(seasons)")}).count
            } else {
            counter = self.episodes.filter({$0.episode.contains("S\(seasons)")}).count
            }
            if counter == 0 { break }
            seasons += 1
        }
        seasons -= 1
    }
    //episodesWithSections creating
    func episodesWithSectionsCreating(){
        for number in 1...seasons{
            if number < 10{
                episodesWithSections.append(GenericData(header: "SEASON \(number)", row: episodes.filter({$0.episode.contains("S0\(number)")})))
            } else {
                episodesWithSections.append(GenericData(header: "SEASON \(number)", row: episodes.filter({$0.episode.contains("S\(number)")})))
            }
        }
    }
    
    func sendData(episode: Episodes){
        EpisodeDetailsVM.selectedEpisodeData = episode
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
