//
//  AuthViewModel.swift
//  RickAndMortyMVVM
//
//  Created by Никита Ломовцев on 04.09.2021.
//

import Foundation
import Firebase

protocol AuthViewModelDelegate: AnyObject{
    func dismiss()
    func showAlert(description: String)
}

final class AuthViewModel{
   weak var delegate: AuthViewModelDelegate?
    
//MARK: Auth SignIn
    func signIn(email: String?, password: String?){
        guard let email = email else { return }
        guard let pass = password else { return }
        if (!email.isEmpty && !pass.isEmpty){
            if pass.count > 7{
                Auth.auth().signIn(withEmail: email, password: pass) {result, error in
                    guard error == nil else {
                        self.tellDelegateToShowAlert(description: "\(error!.localizedDescription)")
                        return
                    }
                    self.tellDelegateToDismiss()
                }
            }
            else { tellDelegateToShowAlert(description: Errors.shortPassword.rawValue)}
        }
        else { tellDelegateToShowAlert(description: Errors.emptyUsernameOrPassword.rawValue)}
    }
    
//MARK: Auth SignUp
    func signUp(email: String?, password: String?){
        guard let email = email else { return }
        guard let pass = password else { return }
        if !email.isEmpty && !pass.isEmpty{
            if pass.count > 7{
                Auth.auth().createUser(withEmail: email, password: pass) { result, error in
                    guard error == nil else {
                        self.tellDelegateToShowAlert(description: "\(error!.localizedDescription)")
                        return
                    }
                    guard let result = result else { return }
                    print(result.user.uid)
                    let ref = Database.database().reference().child("users")
                    ref.child(result.user.uid).updateChildValues(["email" : email])
                    self.tellDelegateToDismiss()
                }
            }
            else { tellDelegateToShowAlert(description: Errors.shortPassword.rawValue)}
        }
        else { tellDelegateToShowAlert(description: Errors.emptyUsernameOrPassword.rawValue)}
    }
    
//MARK: Delegate functions
    func tellDelegateToDismiss(){
        delegate?.dismiss()
    }
    
    func tellDelegateToShowAlert(description: String){
        delegate?.showAlert(description: description)
    }
}
