//
//  ProfileVM.swift
//  Cooky
//
//  Created by Omer Keskin on 27.05.2024.
//

import Foundation

class ProfileVM{
    
    var repo = Repository()
    
    func signOut(){
        
        repo.signOutUser { success in
            if success {

            } else {
           
                print("Failed to sign out")
            }
        }
    }

    
}
