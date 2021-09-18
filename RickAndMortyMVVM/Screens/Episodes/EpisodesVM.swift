//
//  EpisodesVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 06.09.2021.
//

import Foundation
import UIKit

final class EpisodesVM: GenericTableVM {

    override var presentationVC: UIViewController { return UIStoryboard(name: "EpisodeDetails", bundle: nil).instantiateViewController(identifier: "EpisodeDetailsVC") }
    
    static var selectedEpisode: Episodes?
    var pages: Int?
    var episodes:[Episodes] = []
    var seasons = 1 //temporary value, will calculate later
    
    
    override func getData(){
        tellDelegateToStartSpinner()
        getPagesCount {
            self.getJsonData { [self] in
                self.episodes = self.episodes.sorted(by: {$0.id < $1.id})
                self.countOfSeasons()
                self.generateData()
                self.tellDelegateToStopSpinner()
                self.tellDelegateToReloadData()
            }
        }
    }
    
//MARK: Get count of Json pages
    func getPagesCount(completion: @escaping () -> Void){
        NetworkManager.shared.downloadData(urlString: RequestURLS.episodesPageURL.rawValue, dataType: EpisodesData.self) { result in
                self.pages = result.info.pages
                completion()
        }
    }
    
//MARK: JsonData for episodes
    func getJsonData(completion: @escaping () -> Void){
        let dispatchGroup = DispatchGroup()
        guard let pages = pages else { return }
        for number in 1...pages{
            dispatchGroup.enter()
            NetworkManager.shared.downloadData(urlString: "\(RequestURLS.episodesPageURL.rawValue)\(number)", dataType: EpisodesData.self) { result in
                self.episodes.append(contentsOf: result.results)
                    dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main){
        completion()
        }
    }

//MARK: Calculate the number of seasons
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

    
//MARK: Generate data to fill the table
    func generateData(){
        for number in 1...seasons{
            if number < 10{
                data.append(GenericData(header: "SEASON \(number)", row: episodes.filter({$0.episode.contains("S0\(number)")})))
            } else {
                data.append(GenericData(header: "SEASON \(number)", row: episodes.filter({$0.episode.contains("S\(number)")})))
            }
        }
    }
    
//MARK: sendData
    override func sendData(_ data: Any){
        if let episode = data as? Episodes {
            EpisodeDetailsVM.selectedEpisodeData = episode
        }
    }
    
}
