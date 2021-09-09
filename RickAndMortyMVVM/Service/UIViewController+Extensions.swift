//
//  UIViewController+Extensions.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 06.09.2021.
//

import UIKit

extension UIViewController{
    
    var spinnerTag: Int {return 777}
    
    func spinnerStart(){
        DispatchQueue.main.async{
            let spinner = UIActivityIndicatorView(style: .large)
            
            spinner.tag = self.spinnerTag
            spinner.color = .white
            spinner.center = self.view.center
            spinner.hidesWhenStopped = true
            spinner.startAnimating()
            self.view.addSubview(spinner)
        }
    }
    
    func spinnerStop() {
        DispatchQueue.main.async{
                if let spinner = self.view.subviews.filter(
                    { $0.tag == self.spinnerTag}).first as? UIActivityIndicatorView {
                    spinner.stopAnimating()
                    spinner.removeFromSuperview()
                }
            }
        }
}

