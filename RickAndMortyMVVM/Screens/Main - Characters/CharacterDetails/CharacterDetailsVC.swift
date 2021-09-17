//
//  CharacterDetailsVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 03.09.2021.
//

import UIKit
import Kingfisher

class CharacterDetailsVC: GenericTableViewController, GenericTableViewModelDelegate {
    
    @IBOutlet weak var characterDetailsTableView: UITableView!
    
    var viewModel = CharacterDetailsVM()
    override var data: [GenericData] { return viewModel.characterDetails }
    override var presentationVC: UIViewController { return viewModel.episodeDetailsVC }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func sendData(data: Any) {
        viewModel.sendData(episode: data as! Episodes)
    }
    
    func setupView(){
        allowedSelectionSection = 4
        characterDetailsTableView.delegate = self
        characterDetailsTableView.dataSource = self
        viewModel.delegate = self
        viewModel.getData()
    }
    
    func startSpinner(){
        spinnerStart()
    }
    
    func stopSpinner() {
        spinnerStop()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.characterDetailsTableView.reloadData()
        }
    }
    deinit {
        print("CharacterDetailsVC DEINIT")
    }
}

//MARK: Table View Config
extension CharacterDetailsVC {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.characterDetails[indexPath.section].row[indexPath.row]
        switch indexPath.section {
        case 0:
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "SnapshotCell", for: indexPath) as! CharacterDetailsCell
            cell.configureSnapshotCell(data: data as! String)
            return cell
        case 1:
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! CharacterDetailsCell
            cell.configureNameCell(data: data as! String)
            return cell
        case 2:
            let staticText = viewModel.infoStaticText[indexPath.row]
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "InfoLocationCell", for: indexPath) as! CharacterDetailsCell
            cell.configureInfoLocationCell(data: data as! String, staticText: staticText)
            return cell
        case 3:
            let staticText = viewModel.locationStaticText[indexPath.row]
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "InfoLocationCell", for: indexPath) as! CharacterDetailsCell
            cell.configureInfoLocationCell(data: data as! String, staticText: staticText)
            return cell
        default:
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "EpisodesCell", for: indexPath) as! CharacterDetailsCell
            cell.configureEpisodesCell(data: data as! Episodes)
            return cell
        }
    }
}
