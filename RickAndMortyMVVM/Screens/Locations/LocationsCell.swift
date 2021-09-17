//
//  LocationsCell.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 08.09.2021.
//

import UIKit

class LocationsCell: UITableViewCell {

    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var residentsLbl: UILabel!
 
    
    func configure(data model: Locations){
        nameLbl.text = model.name
        residentsLbl.text = "\(model.residents.count) resident(s)"
        bgImg.layer.cornerRadius = 10
    }

}
