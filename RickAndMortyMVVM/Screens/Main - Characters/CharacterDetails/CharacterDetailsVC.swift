//
//  CharacterDetailsVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 03.09.2021.
//

import UIKit
import Kingfisher

class CharacterDetailsVC: UIViewController, CharacterDetailsVMDelegate {
    
    @IBOutlet weak var characterDetailsTableView: UITableView!
    
    var viewModel = CharacterDetailsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characterDetailsTableView.delegate = self
        characterDetailsTableView.dataSource = self
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
            self.characterDetailsTableView.reloadData()
        }
    }
    deinit {
        print("CharacterDetailsVC DEINIT")
    }
}

//MARK: Table View Config
extension CharacterDetailsVC: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.characterDetails.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characterDetails[section].row.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.characterDetails[section].header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.characterDetails[indexPath.section].row[indexPath.row]
        if indexPath.section == 0{
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "SnapshotCell", for: indexPath) as! CharacterDetailsCell
            cell.configureSnapshotCell(data: data as! String)
            return cell
        }
        if indexPath.section == 1{
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! CharacterDetailsCell
            cell.configureNameCell(data: data as! String)
            return cell
        }
        if indexPath.section == 2{
            let staticText = viewModel.infoStaticText[indexPath.row]
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "InfoLocationCell", for: indexPath) as! CharacterDetailsCell
            cell.configureInfoLocationCell(data: data as! String, staticText: staticText)
            return cell
        }
        if indexPath.section == 3{
            let staticText = viewModel.locationStaticText[indexPath.row]
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "InfoLocationCell", for: indexPath) as! CharacterDetailsCell
            cell.configureInfoLocationCell(data: data as! String, staticText: staticText)
            return cell
        }
        
        let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "EpisodesCell", for: indexPath) as! CharacterDetailsCell
        cell.configureEpisodesCell(data: data as! Episodes)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 4{
            viewModel.sendData(episode: viewModel.characterDetails[indexPath.section].row[indexPath.row] as! Episodes )
        self.present(viewModel.episodeDetailsVC, animated: true, completion: nil)
        }
    }
}
