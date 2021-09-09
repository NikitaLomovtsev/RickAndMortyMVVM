//
//  DetailsViewController.swift
//  JsonParsRickAndMorty
//
//  Created by Никита Ломовцев on 23.08.2021.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var liveStatusLbl: UILabel!
    @IBOutlet weak var statusCircleImageView: UIImageView!
    @IBOutlet weak var speciesLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var episodeLbl: UILabel!
    
    var character: CharacterDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    
}
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    func setupView(){
        nameLbl.text = character?.name
        let link = character?.image
//        characterImageView.downloaded(from: link!)
        liveStatusLbl.text = character?.status
        statusCircleImageView.layer.cornerRadius = statusCircleImageView.frame.size.width / 2
        switch liveStatusLbl.text {
        case "Alive":
            statusCircleImageView.backgroundColor = .green
        case "Dead":
            statusCircleImageView.backgroundColor = .red
        case "unknown":
            statusCircleImageView.backgroundColor = .yellow
        default:
            statusCircleImageView.backgroundColor = .gray
        }
        speciesLbl.text = character?.species
        genderLbl.text = character?.gender
        locationLbl.text = character?.location.name
        let stringLink = character!.episode.first!
        let stringLinkWithoutAdres = stringLink.dropFirst(32)
        let stringLinkFinal = stringLinkWithoutAdres.replacingOccurrences(of: "/", with: " ")
        
        episodeLbl.text = "\(stringLinkFinal)"
    }
}
