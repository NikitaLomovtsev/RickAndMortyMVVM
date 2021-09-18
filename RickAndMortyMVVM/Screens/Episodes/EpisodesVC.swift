//
//  EpisodesVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 04.09.2021.
//

import UIKit

class EpisodesVC: GenericTableVC<EpisodesVM>{
    
    @IBOutlet weak var episodesTableView: UITableView!
    
    override var tableView: UITableView { return episodesTableView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

//MARK: TableView cell setup
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.data[indexPath.section].row[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodesCell", for: indexPath) as! EpisodesCell
        cell.configure(data: data as! Episodes)
        return cell
    }
    
}
