//
//  LocationsVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 04.09.2021.
//

import UIKit

class LocationsVC: UIViewController, LocationsVMDelegate {
    
    var viewModel = LocationsVM()
    @IBOutlet weak var locationsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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
extension LocationsVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.alphabetLocations.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.alphabetLocations[section].header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.alphabetLocations[section].row.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationsCell", for: indexPath) as! LocationsCell
        cell.configure(model: viewModel.alphabetLocations[indexPath.section].row[indexPath.row] as! Locations)
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.alphabetLocations.map({$0.header})
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.sendData(location: viewModel.alphabetLocations[indexPath.section].row[indexPath.row] as! Locations)
        self.present(viewModel.detailsVC, animated: true, completion: nil)
    }
}
