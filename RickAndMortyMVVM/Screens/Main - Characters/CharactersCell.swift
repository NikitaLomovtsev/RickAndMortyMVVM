//
//  CharactersCell.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 02.09.2021.
//

import UIKit

class CharactersCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusImg: UIImageView!
    @IBOutlet weak var snapshotImg: UIImageView!
    
    
    func configure(model: Characters, image: UIImage){
        statusImg.layer.cornerRadius = statusImg.frame.size.width / 2
        nameLbl.text = model.name
        statusLbl.text = "\(model.status) - \(model.species) - \(model.gender)"
        bgImg.layer.cornerRadius = 10
        switch model.status {
        case "Alive":
            statusImg.backgroundColor = .green
        case "Dead":
            statusImg.backgroundColor = .red
        case "unknown":
            statusImg.backgroundColor = .systemGray
        default:
            statusImg.backgroundColor = .systemGray
        }
        snapshotImg.layer.cornerRadius = 10
        snapshotImg.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        snapshotImg.image = image
    }
    
}
