//
//  EpisodeDetailsVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 08.09.2021.
//

import UIKit
import Kingfisher

class EpisodeDetailsVC: UIViewController, EpisodeDetailsVMDelegate {

    @IBOutlet weak var episodeDetailsTableView: UITableView!
    
    var viewModel = EpisodeDetailsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
extension EpisodeDetailsVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.episodeDetails.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.episodeDetails[section].row.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.episodeDetails[section].header
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.episodeDetails[indexPath.section].row[indexPath.row]
        if indexPath.section == 0{
            let cell = episodeDetailsTableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! EpisodeDetailsCell
            let staticText = viewModel.infoStaticText[indexPath.row]
            cell.configureInfo(data: data as! String, staticText: staticText)
            return cell
        }
        let cell = episodeDetailsTableView.dequeueReusableCell(withIdentifier: "ResidentsCell", for: indexPath) as! EpisodeDetailsCell
        cell.configureCharacters(data: data as! Characters)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            viewModel.sendData(character: viewModel.episodeDetails[indexPath.section].row[indexPath.row] as! Characters )
        self.present(viewModel.characterDetailsVC, animated: true, completion: nil)
        }
    }
}
