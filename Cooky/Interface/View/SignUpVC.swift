//
//  SignUpVC.swift
//  Cooky
//
//  Created by Omer Keskin on 29.05.2024.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpVC: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.font = UIFont(name: "Pacifico-Regular", size: 41)
        titleLabel.textColor = .white
        
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
    }
    
    
    @objc func hideKeyboard(){
        view.endEditing(true)}


    @IBAction func createAccountClicked(_ sender: Any) {
        
        if emailTF.text != "" || passwordTF.text != ""{
           Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { (authdata, error) in
                if error != nil{
                    self.alertFunc(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Please enter e-mail and password")
                }
                else{
                    
                    let fireStore = Firestore.firestore()
                    let userDictionary  = ["email": self.emailTF.text!] as [String:Any]
                    fireStore.collection("UserInfo").addDocument(data: userDictionary) { (error) in
                        if error != nil{
                            self.alertFunc(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Error")
                        }
                    }
                    
                    let warning = UIAlertController(title: "Account Created", message: "Please sign in", preferredStyle: UIAlertController.Style.alert)
                    let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){_ in
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    warning.addAction(okButton)
                    self.present(warning, animated: true, completion: nil)

               }
            }
        }
        else{
            alertFunc(alertTitle: "Sign Up Error", alertMessage: "Please enter e-mail and password")
        }
        
        
        
    }
    
    
    
    
    @objc func alertFunc(alertTitle: String, alertMessage: String){
        let warning = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        warning.addAction(okButton)
        self.present(warning, animated: true, completion: nil)
    }
    
}
