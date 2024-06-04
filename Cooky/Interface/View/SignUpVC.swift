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
    
    var signUpVM = SignUpVM()
    
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
        
        signUpVM.signUpFunc(VC: self, userName: emailTF, password: passwordTF)

        
        
    }
    
    
}
