//
//  LocationDetailsVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 10.09.2021.
//

import UIKit

class LocationDetailsVC: GenericTableVC<LocationDetailsVM> {
    
    @IBOutlet weak var locationDetailsTableView: UITableView!
    override var tableView: UITableView { return locationDetailsTableView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK: TableView cell setup
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.data[indexPath.section].row[indexPath.row]
        switch indexPath.section {
        case 0:
            let cell = locationDetailsTableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! LocationDetailsCell
            let staticText = viewModel.infoStaticText[indexPath.row]
            cell.configureInfo(data: data as! String, staticText: staticText)
            return cell
        default:
            let cell = locationDetailsTableView.dequeueReusableCell(withIdentifier: "ResidentsCell", for: indexPath) as! LocationDetailsCell
            cell.configureCharacters(data: data as! Characters)
            return cell
        }
    }
}
