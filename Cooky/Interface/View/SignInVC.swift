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
    

    var signInVM = SignInVM()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.font = UIFont(name: "Pacifico-Regular", size: 41)
        titleLabel.textColor = .white
        
       
    }
    

    
    @IBAction func signInClicked(_ sender: Any) {
        

        signInVM.signInFunc(VC: self, userName: usernameTF, password: passwordTF)
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toSignUpVC", sender: nil)
    }
    
    

}
