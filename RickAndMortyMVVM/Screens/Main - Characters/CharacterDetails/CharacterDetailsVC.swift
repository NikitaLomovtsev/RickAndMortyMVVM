//
//  CharacterDetailsVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 03.09.2021.
//

import UIKit
import Kingfisher

class CharacterDetailsVC: GenericTableVC<CharacterDetailsVM> {
    
    @IBOutlet weak var characterDetailsTableView: UITableView!
    
    override var tableView: UITableView { return characterDetailsTableView }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK: TableView cell setup
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.data[indexPath.section].row[indexPath.row]
        switch indexPath.section {
        case 0:
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "SnapshotCell", for: indexPath) as! CharacterDetailsCell
            cell.configureSnapshotCell(data: data as! String)
            return cell
        case 1:
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! CharacterDetailsCell
            cell.configureNameCell(data: data as! String)
            return cell
        case 2:
            let staticText = viewModel.infoStaticText[indexPath.row]
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "InfoLocationCell", for: indexPath) as! CharacterDetailsCell
            cell.configureInfoLocationCell(data: data as! String, staticText: staticText)
            return cell
        case 3:
            let staticText = viewModel.locationStaticText[indexPath.row]
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "InfoLocationCell", for: indexPath) as! CharacterDetailsCell
            cell.configureInfoLocationCell(data: data as! String, staticText: staticText)
            return cell
        default:
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "EpisodesCell", for: indexPath) as! CharacterDetailsCell
            cell.configureEpisodesCell(data: data as! Episodes)
            return cell
        }
    }

}
