//
//  GenericTableViewController.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 16.09.2021.
//

import UIKit

class GenericTableViewController: UIViewController {
    var allowedSelectionSection: Int?
    
    var data: [GenericData] { return [GenericData(header: "", row: [])] }
    
    var presentationVC: UIViewController { return self }
    
    func sendData(data: Any) {
    }

}

extension GenericTableViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].header
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[section].row.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (allowedSelectionSection == nil || indexPath.section == allowedSelectionSection!) {
            sendData(data: self.data[indexPath.section].row[indexPath.row])
            self.present(self.presentationVC, animated: true, completion: nil)
        }
    }
}

