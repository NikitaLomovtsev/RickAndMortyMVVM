//
//  SuperVM.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 15.09.2021.
//

import UIKit

class SuperVM{
    func tellDelegateToStartSpinner(delegate: UIViewController){
        delegate.spinnerStart()
    }
    
    func tellDelegateToStopSpinner(delegate: UIViewController){
        delegate.spinnerStop()
    }
    
//    func tellDelegateToReloadData(delegate: UIViewController){
//        delegate.reloadData()
//    }
}
