//
//  EpisodesVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 04.09.2021.
//

import UIKit

class EpisodesVC: GenericTableViewController, GenericTableViewModelDelegate {
    
    var viewModel = EpisodesVM()
    override var data: [GenericData] { return viewModel.episodesWithSections }
    override var presentationVC: UIViewController { return viewModel.detailsVC }
    
    @IBOutlet weak var episodesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
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

//MARK: Table View Config
extension EpisodesVC {

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = viewModel.episodesWithSections[indexPath.section].row[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodesCell", for: indexPath) as! EpisodesCell
        cell.configure(data: data as! Episodes)
        return cell
    }
}
