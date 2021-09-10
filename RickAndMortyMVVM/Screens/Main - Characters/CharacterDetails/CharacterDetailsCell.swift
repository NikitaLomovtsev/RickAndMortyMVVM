//
//  CharacterDetailsCell.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 05.09.2021.
//

import UIKit

class CharacterDetailsCell: UITableViewCell {
    
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var infoLbl: UILabel!
    @IBOutlet weak var snapshotImg: UIImageView!
    @IBOutlet weak var staticLbl: UILabel!

    
    func configureSnapshotCell(data model: String){
        snapshotImg.kf.indicatorType = .activity
        snapshotImg.kf.setImage(with: URL(string: model), placeholder: UIImage(named: "loadingSnaphot"), options: [.transition(.fade(0.4))])
        snapshotImg.layer.cornerRadius = 10
    }
    
    func configureNameCell(data model: String){
        infoLbl.text = model
        bgImg.layer.cornerRadius = 10
    }
    
    func configureInfoLocationCell(data model: String, staticText: String){
        infoLbl.text = model
        staticLbl.text = staticText
        bgImg.layer.cornerRadius = 10
    }
    
    func configureEpisodesCell(data model: Episodes){
        infoLbl.text = model.name
        bgImg.layer.cornerRadius = 10
    }
    
}
