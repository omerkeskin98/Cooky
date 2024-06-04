//
//  DetailVM.swift
//  Cooky
//
//  Created by Omer Keskin on 27.05.2024.
//

import Foundation
import RxSwift


class DetailVM{
    
    
    var itemList = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    var repo = Repository()
    
    init(){
        
        itemList = repo.itemList
    }
    

    func getItems(){
        repo.getItems()
    }
    
}
