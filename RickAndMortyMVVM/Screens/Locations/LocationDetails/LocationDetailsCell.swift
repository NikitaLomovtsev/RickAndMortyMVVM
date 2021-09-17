//
//  LocationDetailsCell.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 10.09.2021.
//

import UIKit

class LocationDetailsCell: BasicGenericTableViewCell {

    @IBOutlet weak var snapshotImg: UIImageView!

    override func configure(_ data: Any) {
        super.configure(data)
        if let model = data as? Characters {
            infoLbl.text = model.name
            snapshotImg.kf.indicatorType = .activity
            snapshotImg.kf.setImage(with: URL(string: model.image), placeholder: UIImage(named: "loadingSnaphot"), options: [.transition(.fade(0.4))])
            snapshotImg.layer.cornerRadius = 10
            snapshotImg.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
    }
}
