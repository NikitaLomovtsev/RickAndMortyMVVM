//
//  EpisodeDetailsVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 08.09.2021.
//

import UIKit
import Kingfisher

class EpisodeDetailsVC: GenericTableViewController, EpisodeDetailsVMDelegate {

    @IBOutlet weak var episodeDetailsTableView: UITableView!
    
    var viewModel = EpisodeDetailsVM()
    
    override var data: [GenericData] { return viewModel.episodeDetails }
    override var presentationVC: UIViewController { return viewModel.characterDetailsVC }
    
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
        episodeDetailsTableView.delegate = self
        episodeDetailsTableView.dataSource = self
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
            self.episodeDetailsTableView.reloadData()
        }
    }
    
    deinit {
        print("EpisodeDetailsVC DEINIT")
    }
    
}
