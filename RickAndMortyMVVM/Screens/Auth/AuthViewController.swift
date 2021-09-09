//
//  AuthViewController.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 04.09.2021.
//

import UIKit
import Firebase

class AuthViewController: UIViewController, AuthViewModelDelegate {
    
    var authViewModel = AuthViewModel()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.autocorrectionType = .no
        authViewModel.delegate = self
    }
    //Buttons
    @IBAction func signInAction(_ sender: Any) {
        authViewModel.signIn(email: emailTextField.text, password: passwordTextField.text)
    }
    @IBAction func signUpAction(_ sender: Any) {
        authViewModel.signUp(email: emailTextField.text, password: passwordTextField.text)
    }
    //Dismiss AuthViewController
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    //Alert
    func showAlert(description: String) {
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: nil)
    }

}

