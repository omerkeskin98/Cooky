//
//  UserSingleton.swift
//  Cooky
//
//  Created by Omer Keskin on 30.05.2024.
//

import Foundation

class UserSingleton{
    
    
    static let shareUserInfo = UserSingleton()
    
    var email = ""
    
    private init() {

    }
}
