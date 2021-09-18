//
//  CharactersVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 02.09.2021.
//

import UIKit
import Firebase

class CharactersVC: GenericTableVC<CharactersVM>{
    
    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override var tableView: UITableView { return charactersTableView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        //Change color of search bar left icon
        if let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField,
           let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = UIColor(named: "yellowgreen")
        }
    }
    
//MARK: TableView cell setup
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharactersCell
        let model = viewModel.data[indexPath.section].row[indexPath.row]
        cell.configure(model: model as! Characters)
        return cell
    }
    
//MARK: ShakeToSignOut
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            do{
                try Auth.auth().signOut()
            }catch {
                print(error)
            }
        }
    }
    
}


//MARK: Search Bar Config
extension CharactersVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        viewModel.search(text: text)
    }
    
    //Keyboard dismiss after tapping search button
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchBar.endEditing(true)
    }
    
}
