//
//  LocationDetailsVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 10.09.2021.
//

import Foundation
import UIKit

final class LocationDetailsVM: GenericTableVM {
    
    override var presentationVC: UIViewController? { return UIStoryboard(name: "CharacterDetails", bundle: nil).instantiateViewController(identifier: "CharacterDetailsVC") }
    
    static var selectedLocationData: Locations?
    var selectedLocation: Locations? { return LocationDetailsVM.selectedLocationData}
    var characters: [Characters] = []
    var infoStaticText = ["Name", "Dimension", "Type"]
    
    
    override func getData(){
        allowedSelectionSection = 1
        tellDelegateToStartSpinner()
        getCharactersForSelectedLocation {
            self.generateData()
            self.tellDelegateToStopSpinner()
            self.tellDelegateToReloadData()
        }
    }
    
//MARK: Get characters from Json
    func getCharactersForSelectedLocation(completion: @escaping() -> Void){
        let dispatchGroup = DispatchGroup()
        for element in selectedLocation!.residents{
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
        guard let selectedLocation = selectedLocation else { return }
        data = [
            GenericData(header: "INFO", row: [selectedLocation.name, selectedLocation.dimension, selectedLocation.type]),
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
