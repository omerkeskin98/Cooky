//
//  SignInVC.swift
//  Cooky
//
//  Created by Omer Keskin on 27.05.2024.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInVC: UIViewController {
    

    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.font = UIFont(name: "Pacifico-Regular", size: 41)
        titleLabel.textColor = .white
        
       
    }
    

    
    @IBAction func signInClicked(_ sender: Any) {
        
        if usernameTF.text != "" || passwordTF.text != ""{
            Auth.auth().signIn(withEmail: usernameTF.text!, password: passwordTF.text!) { (authdata, error) in
                 if error != nil{
                     self.alertFunc(alertTitle: "Error", alertMessage: error?.localizedDescription ?? "Error")
                 }
                 else{
                     self.performSegue(withIdentifier: "toMainPageVC", sender: nil)
                }
             }
        }
        else{
            alertFunc(alertTitle: "Sign In Error", alertMessage: "Please fill email and password")
        }
        
        

    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
    
    
    @objc func alertFunc(alertTitle: String, alertMessage: String){
        let warning = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        warning.addAction(okButton)
        self.present(warning, animated: true, completion: nil)
    }
 
    
    

}
