//
//  EpisodeDetailsVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 08.09.2021.
//

import UIKit
import Kingfisher

class EpisodeDetailsVC: GenericTableViewController, GenericTableViewModelDelegate {

    @IBOutlet weak var episodeDetailsTableView: UITableView!
    
    var viewModel = EpisodeDetailsVM()
    
    override var data: [GenericData] { return viewModel.episodeDetails }
    override var presentationVC: UIViewController { return viewModel.characterDetailsVC }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

//MARK: Table View Config
extension EpisodeDetailsVC {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.episodeDetails[indexPath.section].row[indexPath.row]
        switch indexPath.section {
        case 0:
            let cell = episodeDetailsTableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! EpisodeDetailsCell
            let staticText = viewModel.infoStaticText[indexPath.row]
            cell.configureInfo(data: data as! String, staticText: staticText)
            return cell
        default:
            let cell = episodeDetailsTableView.dequeueReusableCell(withIdentifier: "ResidentsCell", for: indexPath) as! EpisodeDetailsCell
            cell.configureCharacters(data: data as! Characters)
            return cell
        }
    }
}
