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
        if indexPath.section == 0{
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "SnapshotCell", for: indexPath) as! CharacterDetailsCell
            cell.snapshotImg.layer.cornerRadius = 10
            cell.snapshotImg.kf.indicatorType = .activity
            cell.snapshotImg.kf.setImage(with: URL(string: viewModel.characterDetails[indexPath.section].row.first!), placeholder: UIImage(named: "loadingSnapshot"), options: [.transition(.fade(0.4))])
            return cell
        }
        
        if indexPath.section == 1{
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! CharacterDetailsCell
            cell.bgImg.layer.cornerRadius = 10
            cell.infoLbl.text = viewModel.characterDetails[indexPath.section].row[indexPath.row]
            return cell
        }
        
        if indexPath.section == 2{
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "InfoLocationCell", for: indexPath) as! CharacterDetailsCell
            cell.infoLbl.text = viewModel.characterDetails[indexPath.section].row[indexPath.row]
            cell.staticLbl.text = viewModel.infoStaticText[indexPath.row]
            cell.bgImg.layer.cornerRadius = 10
            return cell
        }
        
        if indexPath.section == 3{
            let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "InfoLocationCell", for: indexPath) as! CharacterDetailsCell
            cell.infoLbl.text = viewModel.characterDetails[indexPath.section].row[indexPath.row]
            cell.staticLbl.text = viewModel.locationStaticText[indexPath.row]
            cell.bgImg.layer.cornerRadius = 10
            return cell
        }
        
        let cell = characterDetailsTableView.dequeueReusableCell(withIdentifier: "EpisodesCell", for: indexPath) as! CharacterDetailsCell
        cell.bgImg.layer.cornerRadius = 10
        cell.infoLbl.text = viewModel.characterDetails[indexPath.section].row[indexPath.row]
        return cell
    }
}
