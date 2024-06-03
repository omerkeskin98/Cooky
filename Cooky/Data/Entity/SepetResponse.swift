//
//  SepetResponse.swift
//  Cooky
//
//  Created by Omer Keskin on 22.05.2024.
//

import Foundation

class SepetResponse: Codable{

    static let shared = SepetResponse()
    
    var sepet_yemekler : [SepetYemekler]?
    var success : Int?
    
    private init(){
        
    }
    
    init(sepet_yemekler: [SepetYemekler], success: Int) {
        self.sepet_yemekler = sepet_yemekler
        self.success = success
    }
}
