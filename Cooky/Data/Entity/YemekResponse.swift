//
//  YemekResponse.swift
//  Cooky
//
//  Created by Omer Keskin on 22.05.2024.
//

import Foundation

class YemekResponse: Codable{
    
    var yemekler : [Yemekler]?
    var success : Int?
    
    
    init(yemekler: [Yemekler], success: Int) {
        self.yemekler = yemekler
        self.success = success
    }
    
}
