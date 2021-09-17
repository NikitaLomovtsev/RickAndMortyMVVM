//
//  GenericTableVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 17.09.2021.
//

import Foundation

protocol GenericTableViewModelDelegate: AnyObject{
    func reloadData()
    func startSpinner()
    func stopSpinner()
}

class GenericTableViewModel {
    weak var delegate: GenericTableViewModelDelegate?
    
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
