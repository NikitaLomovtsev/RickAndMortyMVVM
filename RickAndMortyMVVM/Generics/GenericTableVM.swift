//
//  GenericTableVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 17.09.2021.
//

import Foundation
import UIKit

protocol GenericTableVMDelegate: AnyObject{
    func reloadData()
    func startSpinner()
    func stopSpinner()
}

class GenericTableVM {
    weak var delegate: GenericTableVMDelegate?
    required init() {
    }
    
    
//MARK:    /* MUST BE FULFILLED IN VIEW MODEL*/
    
    var allowedSelectionSection: Int?
    //Section number that can be selected. Do not override if all sections can be selected
    //-1 to disable section selection
    
    var presentationVC: UIViewController? { return nil }
    //ViewController to show details information
    
    var data: [GenericData] = []
    //Final data to display in tableView. Must match to the [GenericData] type
    
    func getData() {
    }
    //Method that includes all methods for obtaining data
    
    func sendData(_ data: Any) {
    }
    //Method responsible for transferring data to details ViewController
    
    
    
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
