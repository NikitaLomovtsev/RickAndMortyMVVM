//
//  EpisodesVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 04.09.2021.
//

import UIKit

class EpisodesVC: UIViewController, EpisodesVMDelegate {
    
    var viewModel = EpisodesVM()
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
extension EpisodesVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.episodesWithSections[section].row.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.episodesWithSections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.episodesWithSections[section].header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodesCell", for: indexPath) as! EpisodesCell
        cell.configure(data: viewModel.episodesWithSections[indexPath.section].row[indexPath.row] as! Episodes)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.sendData(episode: viewModel.episodesWithSections[indexPath.section].row[indexPath.row] as! Episodes)
        self.present(viewModel.detailsVC, animated: true, completion: nil)
    }
}
