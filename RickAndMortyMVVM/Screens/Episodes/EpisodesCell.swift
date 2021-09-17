//
//  GenericTableViewDataCell.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 06.09.2021.
//

import UIKit

class EpisodesCell: UITableViewCell {

    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var episodeLbl: UILabel!
    @IBOutlet weak var airDateLbl: UILabel!


    func configure(data model: Episodes){
        nameLbl.text = model.name
        episodeLbl.text = model.episode
        airDateLbl.text = model.airDate
        bgImg.layer.cornerRadius = 10
    }

}
