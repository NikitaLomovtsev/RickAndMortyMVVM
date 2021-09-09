//
//  EpisodeDetailsCell.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 08.09.2021.
//

import UIKit
import Kingfisher

class EpisodeDetailsCell: UITableViewCell {

    @IBOutlet weak var snapshotImg: UIImageView!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var staticLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    
    
    func configureInfo(data model: String, staticText: String){
        bgImg.layer.cornerRadius = 10
        infoLbl.text = model
        staticLbl.text = staticText
    }

    func configureCharacters(data model: Characters){
        bgImg.layer.cornerRadius = 10
        infoLbl.text = model.name
        snapshotImg.kf.setImage(with: URL(string: model.image))
        snapshotImg.layer.cornerRadius = 10
        snapshotImg.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
}
