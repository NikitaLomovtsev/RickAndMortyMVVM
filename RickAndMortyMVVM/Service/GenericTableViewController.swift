//
//  GenericTableViewController.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 16.09.2021.
//

import UIKit

class BasicGenericTableViewCell: UITableViewCell {
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var staticLbl: UILabel!
    @IBOutlet weak var infoLbl: UILabel!
    
    @objc override func configure(_ data: Any) {
        bgImg.layer.cornerRadius = 10
        if let data = data as? [String: String],
           let title = data["title"],
           let text = data["text"] {
            staticLbl.text = title
            infoLbl.text = text
        }
    }
}

class GenericTableViewController: UIViewController {
    var allowedSelectionSection: Int?
    
    var cellIds: [Int: String] = [:]
    var data: [GenericData] { return [GenericData(header: "", row: [])] }
    var presentationVC: UIViewController { return self }
    
    func sendData(data: Any) {
    }

}

@objc extension UITableViewCell {
    func configure(_ data: Any) {
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
        let data = self.data[indexPath.section].row[indexPath.row]
        let cellId = self.cellIds[indexPath.section] ?? self.cellIds[-1] ?? ""
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.configure(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (allowedSelectionSection == nil || indexPath.section == allowedSelectionSection!) {
            sendData(data: self.data[indexPath.section].row[indexPath.row])
            self.present(self.presentationVC, animated: true, completion: nil)
        }
    }
    
    
}
