//
//  LocationDetailsVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 10.09.2021.
//

import Foundation
import UIKit

protocol LocationDetailsVMDelegate: AnyObject{
    func reloadData()
    func startSpinner()
    func stopSpinner()
}

final class LocationDetailsVM{
    weak var delegate: LocationDetailsVMDelegate?
    static var selectedLocationData: Locations?
    var selectedLocation: Locations? { return LocationDetailsVM.selectedLocationData}
    var locationDetails: [AlphabetLocations] = []
    var characters: [Characters] = []
    var infoStaticText = ["Name", "Dimension", "Type"]
    
    
    func getData(){
        tellDelegateToStartSpinner()
        getCharactersForSelectedLocation {
            self.generateDataForSelectedLocation()
            self.tellDelegateToStopSpinner()
            self.tellDelegateToReloadData()
        }
    }
    
    func getCharactersForSelectedLocation(completion: @escaping() -> Void){
        let dispatchGroup = DispatchGroup()
        for element in selectedLocation!.residents{
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
    
    func generateDataForSelectedLocation(){
        guard let selectedLocation = selectedLocation else { return }
        locationDetails = [
            AlphabetLocations(header: "INFO", row: [selectedLocation.name, selectedLocation.dimension, selectedLocation.type]),
            AlphabetLocations(header: "CHARACTERS", row: characters)
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
