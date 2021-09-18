
//
//  GenericTableVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 16.09.2021.
//

import UIKit

class GenericTableVC<T: GenericTableVM>: UIViewController, UITableViewDataSource, UITableViewDelegate, GenericTableVMDelegate {
    var viewModel = T()
    
    var tableView: UITableView { return UITableView() }
    
//MARK: ViewController functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        viewModel.getData()
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func startSpinner() {
        spinnerStart()
    }
    
    func stopSpinner() {
        spinnerStop()
    }

//MARK: TableView methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.data[section].header
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data[section].row.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard viewModel.allowedSelectionSection != -1 else { return }
        if (viewModel.allowedSelectionSection == nil || indexPath.section == viewModel.allowedSelectionSection!) {
            viewModel.sendData(viewModel.data[indexPath.section].row[indexPath.row])
            if let vc = viewModel.presentationVC {
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}
