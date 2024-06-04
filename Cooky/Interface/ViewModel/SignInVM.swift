//
//  SignInVM.swift
//  Cooky
//
//  Created by Omer Keskin on 27.05.2024.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class SignInVM{
    
    
    func signInFunc(VC: UIViewController, userName: UITextField, password:UITextField){
        
        
        if userName.text != "" || password.text != ""{
            Auth.auth().signIn(withEmail: userName.text!, password: password.text!) { (authdata, error) in
                 if error != nil{
                     let warning = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                     let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                     warning.addAction(okButton)
                     VC.present(warning, animated: true, completion: nil)
                 }
                 else{
                     VC.performSegue(withIdentifier: "toMainPageVC", sender: nil)
                }
             }
        }
        else{
            let warning = UIAlertController(title: "Sign In Error", message: "Please fill email and password", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            warning.addAction(okButton)
            VC.present(warning, animated: true, completion: nil)
  
        }
        
    }
    
    
}
