//
//  LocationsVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 06.09.2021.
//

import Foundation
import UIKit



final class LocationsVM: GenericTableViewModel{
    
    static var selectedEpisode: Locations?
    var pages: Int?
    var locations:[Locations] = []
    var alphabetLocations: [GenericData] = []
    var detailsVC: UIViewController { return UIStoryboard(name: "LocationDetails", bundle: nil).instantiateViewController(identifier: "LocationDetailsVC")}
    
    func getData(){
        tellDelegateToStartSpinner()
        getPagesCount {
            self.getJsonData {
                self.locations = self.locations.sorted(by: {$0.name < $1.name})
                self.alphabetLocationsCreation()
                self.tellDelegateToStopSpinner()
                self.tellDelegateToReloadData()
            }
        }
    }
    
    func getPagesCount(completion: @escaping () -> Void){
        NetworkManager.shared.downloadData(urlString: RequestURLS.locationsPageURL.rawValue, dataType: LocationsData.self) { result in
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
            NetworkManager.shared.downloadData(urlString: "\(RequestURLS.locationsPageURL.rawValue)\(number)", dataType: LocationsData.self) { result in
                switch result{
                case .success(let array):
                    let locationsArray = array.results
                    self.locations.append(contentsOf: locationsArray)
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
    
    
    func alphabetLocationsCreation(){
        for letter in "ABCDEFGHIJKLMNOPQRSTUVWXYZ"{
            guard locations.filter({$0.name.hasPrefix("\(letter)")}).count != 0 else { return }
            alphabetLocations.append(GenericData(header: "\(letter)", row: locations.filter({$0.name.hasPrefix("\(letter)")})))
        }
    }
    
    func sendData(location: Locations){
        LocationDetailsVM.selectedLocationData = location
    }

}
