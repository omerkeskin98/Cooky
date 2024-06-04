//
//  ProfileVC.swift
//  Cooky
//
//  Created by Omer Keskin on 27.05.2024.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {

    
    @IBOutlet weak var userLabel: UILabel!
    let profileVM = ProfileVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Cooky"
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(named: "color1")
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "textColor2")!, .font: UIFont(name: "Pacifico-Regular", size: 27)!]
 
        
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        
        if let userName = Auth.auth().currentUser?.email{
            userLabel.text = "E-mail: \(userName)"
        }
    }
    
    
    
    @IBAction func signOutClicked(_ sender: Any) {
        
        profileVM.signOut()
        performSegue(withIdentifier: "toSignInVC", sender: nil)
        
    }
    

}
