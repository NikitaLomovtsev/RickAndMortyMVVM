//
//  CharactersVC.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 02.09.2021.
//

import UIKit
import Firebase
import Kingfisher

class CharactersVC: UIViewController, CharactersVMDelegate{
    
    var viewModel = CharactersVM()
    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        KingfisherManager.shared.cache.clearCache()
//        KingfisherManager.shared.cache.clearDiskCache()
//        KingfisherManager.shared.cache.cleanExpiredCache()
        setupView()
    }
    
//MARK: Setup View
    func setupView(){
        charactersTableView.delegate = self
        charactersTableView.dataSource = self
        viewModel.delegate = self
        searchBar.delegate = self
        viewModel.getData()
        //Change color of search bar left icon
        if let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField,
           let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {
            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = UIColor(named: "yellowgreen")
        }
    }
    
    //Shake to sign out
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            do{
                try Auth.auth().signOut()
            }catch {
                print(error)
            }
        }
    }
    
    //Keyboard dismiss after tapping search button
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchBar.endEditing(true)
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
            self.charactersTableView.reloadData()
        }
    }
}

//MARK: Table View Config
extension CharactersVC: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCharacters.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharactersCell
        let model = viewModel.filteredCharacters[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.sendData(character: viewModel.filteredCharacters[indexPath.row])
        self.present(viewModel.detailsVC, animated: true, completion: nil)
    }
    
}

//MARK: Search Bar Config
extension CharactersVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        viewModel.search(text: text)
    }
    
    
}
