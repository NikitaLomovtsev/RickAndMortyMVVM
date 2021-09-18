//
//  LocationsVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 04.09.2021.
//

import UIKit

class LocationsVC: GenericTableVC<LocationsVM> {
    
    @IBOutlet weak var locationsTableView: UITableView!
    
    override var tableView: UITableView { return locationsTableView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationsTableView.sectionIndexColor = UIColor(named: "yellowgreen")
    }
    
//MARK: TableView cell setup
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationsCell", for: indexPath) as! LocationsCell
        cell.configure(data: viewModel.data[indexPath.section].row[indexPath.row] as! Locations)
        return cell
    }
    
    //Titles for sectionIndex
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.data.map({$0.header})
    }
}
