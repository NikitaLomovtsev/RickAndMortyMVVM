//
//  LocationDetailsVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 10.09.2021.
//

import UIKit

class LocationDetailsVC: UIViewController, LocationDetailsVMDelegate {

    var viewModel = LocationDetailsVM()
    
    @IBOutlet weak var locationDetailsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationDetailsTableView.delegate = self
        locationDetailsTableView.dataSource = self
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
            self.locationDetailsTableView.reloadData()
        }
    }
    
    deinit {
        print("LocationDetailsVC DEINIT")
    }

}

//MARK: Table View Config
extension LocationDetailsVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.locationDetails.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locationDetails[section].row.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.locationDetails[section].header
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.locationDetails[indexPath.section].row[indexPath.row]
        if indexPath.section == 0{
            let cell = locationDetailsTableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! LocationDetailsCell
            let staticText = viewModel.infoStaticText[indexPath.row]
            cell.configureInfo(data: data as! String, staticText: staticText)
            return cell
        }
        let cell = locationDetailsTableView.dequeueReusableCell(withIdentifier: "ResidentsCell", for: indexPath) as! LocationDetailsCell
        cell.configureCharacters(data: data as! Characters)
        return cell
    }
}

