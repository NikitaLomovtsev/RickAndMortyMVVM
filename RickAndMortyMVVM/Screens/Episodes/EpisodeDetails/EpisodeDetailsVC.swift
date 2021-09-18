//
//  EpisodeDetailsVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 08.09.2021.
//

import UIKit
import Kingfisher

class EpisodeDetailsVC: GenericTableVC<EpisodeDetailsVM> {

    @IBOutlet weak var episodeDetailsTableView: UITableView!
    override var tableView: UITableView { return episodeDetailsTableView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK: TableView cell setup
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.data[indexPath.section].row[indexPath.row]
        switch indexPath.section {
        case 0:
            let cell = episodeDetailsTableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! EpisodeDetailsCell
            let staticText = viewModel.infoStaticText[indexPath.row]
            cell.configureInfo(data: data as! String, staticText: staticText)
            return cell
        default:
            let cell = episodeDetailsTableView.dequeueReusableCell(withIdentifier: "ResidentsCell", for: indexPath) as! EpisodeDetailsCell
            cell.configureCharacters(data: data as! Characters)
            return cell
        }
    }
}
