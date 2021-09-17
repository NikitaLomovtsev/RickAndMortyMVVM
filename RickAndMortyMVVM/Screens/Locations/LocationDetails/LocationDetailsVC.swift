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
        cellIds = [
            0: "InfoCell",
            -1: "ResidentsCell"
        ]
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
