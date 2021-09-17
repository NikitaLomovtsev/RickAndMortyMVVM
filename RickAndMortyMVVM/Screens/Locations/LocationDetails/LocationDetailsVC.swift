//
//  LocationDetailsVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 10.09.2021.
//

import UIKit

class LocationDetailsVC: GenericTableViewController, LocationDetailsVMDelegate {

    var viewModel = LocationDetailsVM()
    override var data: [GenericData] { return viewModel.locationDetails }
    override var presentationVC: UIViewController { return viewModel.characterDetailsVC }
    
    @IBOutlet weak var locationDetailsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func sendData(data: Any) {
        viewModel.sendData(character: data as! Characters)
    }
    
    func setupView(){
        allowedSelectionSection = 1
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
extension LocationDetailsVC {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.locationDetails[indexPath.section].row[indexPath.row]
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

