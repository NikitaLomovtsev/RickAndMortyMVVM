//
//  EpisodesVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 04.09.2021.
//

import UIKit

class EpisodesVC: GenericTableViewController, EpisodesVMDelegate {
    
    var viewModel = EpisodesVM()
    override var data: [GenericData] { return viewModel.episodesWithSections }
    override var presentationVC: UIViewController { return viewModel.detailsVC }
    
    @IBOutlet weak var episodesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellIds = [-1: "EpisodesCell"]
        setupView()
    }
    
    override func sendData(data: Any) {
        viewModel.sendData(episode: data as! Episodes)
        
    }
    
    func setupView(){
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        viewModel.delegate = self
        viewModel.getData()
    }
    
    func startSpinner() {
        spinnerStart()
    }
    
    func stopSpinner() {
        spinnerStop()
    }
    
    //Reload TableView
    func reloadData() {
        DispatchQueue.main.async {
            self.episodesTableView.reloadData()
        }
    }
}
