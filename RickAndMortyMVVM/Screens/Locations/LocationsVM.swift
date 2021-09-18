//
//  LocationsVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 06.09.2021.
//

import Foundation
import UIKit



final class LocationsVM: GenericTableVM{
    
    static var selectedEpisode: Locations?
    var pages: Int?
    var locations:[Locations] = []
    
    override var presentationVC: UIViewController? { return UIStoryboard(name: "LocationDetails", bundle: nil).instantiateViewController(identifier: "LocationDetailsVC")}
    
    override func getData(){
        tellDelegateToStartSpinner()
        getPagesCount {
            self.getJsonData {
                self.locations = self.locations.sorted(by: {$0.name < $1.name})
                self.generateData()
                self.tellDelegateToStopSpinner()
                self.tellDelegateToReloadData()
            }
        }
    }
    
//MARK: Get count of Json pages
    func getPagesCount(completion: @escaping () -> Void){
        NetworkManager.shared.downloadData(urlString: RequestURLS.locationsPageURL.rawValue, dataType: LocationsData.self) { result in
                self.pages = result.info.pages
                completion()
        }
    }
    
//MARK: JsonData for locations
    func getJsonData(completion: @escaping () -> Void){
        let dispatchGroup = DispatchGroup()
        guard let pages = pages else { return }
        for number in 1...pages{
            dispatchGroup.enter()
            NetworkManager.shared.downloadData(urlString: "\(RequestURLS.locationsPageURL.rawValue)\(number)", dataType: LocationsData.self) { result in
                let locationsArray = result.results
                    self.locations.append(contentsOf: locationsArray)
                    dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main){
        completion()
        }
    }
    
//MARK: Generate data to fill the table
    func generateData(){
        for letter in "ABCDEFGHIJKLMNOPQRSTUVWXYZ"{
            guard locations.filter({$0.name.hasPrefix("\(letter)")}).count != 0 else { return }
            data.append(GenericData(header: "\(letter)", row: locations.filter({$0.name.hasPrefix("\(letter)")})))
        }
    }
    
//MARK: sendData
    override func sendData(_ data: Any){
        if let location = data as? Locations {
            LocationDetailsVM.selectedLocationData = location
        }
    }

}
