//
//  LocationsVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 04.09.2021.
//

import UIKit

class LocationsVC: GenericTableViewController, GenericTableViewModelDelegate {
    
    var viewModel = LocationsVM()
    override var data: [GenericData] { return viewModel.alphabetLocations }
    override var presentationVC: UIViewController { return viewModel.detailsVC }
    
    @IBOutlet weak var locationsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func sendData(data: Any) {
        viewModel.sendData(location: data as! Locations)
    }
    
    func setupView(){
        locationsTableView.delegate = self
        locationsTableView.dataSource = self
        locationsTableView.sectionIndexColor = UIColor(named: "yellowgreen")
        viewModel.delegate = self
        viewModel.getData()
    }
    
    func startSpinner() {
        spinnerStart()
    }
    
    func stopSpinner() {
        spinnerStop()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.locationsTableView.reloadData()
        }
    }
}

//MARK: Table View Config
extension LocationsVC {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationsCell", for: indexPath) as! LocationsCell
        cell.configure(data: viewModel.alphabetLocations[indexPath.section].row[indexPath.row] as! Locations)
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.alphabetLocations.map({$0.header})
    }
}
