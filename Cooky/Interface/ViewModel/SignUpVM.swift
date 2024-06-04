//
//  SignUpVM.swift
//  Cooky
//
//  Created by Omer Keskin on 29.05.2024.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore

class SignUpVM{
    
    func signUpFunc(VC: UIViewController, userName: UITextField, password: UITextField){
        
        
        if userName.text != "" || password.text != ""{
           Auth.auth().createUser(withEmail: userName.text!, password: password.text!) { (authdata, error) in
                if error != nil{
                    
                    let warning = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Please enter e-mail and password", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                    warning.addAction(okButton)
                    VC.present(warning, animated: true, completion: nil)
                }
                else{
                    
                    let fireStore = Firestore.firestore()
                    let userDictionary  = ["email": userName.text!] as [String:Any]
                    fireStore.collection("UserInfo").addDocument(data: userDictionary) { (error) in
                        if error != nil{
                            
                            let warning = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                            warning.addAction(okButton)
                            VC.present(warning, animated: true, completion: nil)
                        }
                    }
                    
                    let warning = UIAlertController(title: "Account Created", message: "Please sign in", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){_ in
                        VC.navigationController?.popToRootViewController(animated: true)
                    }
                    warning.addAction(okButton)
                    VC.present(warning, animated: true, completion: nil)

               }
            }
        }
        else{
            
            let warning = UIAlertController(title: "Sign Up Error", message: "Please enter e-mail and password", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            warning.addAction(okButton)
            VC.present(warning, animated: true, completion: nil)
        }
        
        
    }
    

    
}
