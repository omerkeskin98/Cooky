//
//  MainPageVM.swift
//  Cooky
//
//  Created by Omer Keskin on 27.05.2024.
//

import Foundation
import RxSwift
import UIKit

class MainPageVM{
    
    
    var itemList = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    var repo = Repository()
    
    
    init(){
        
        itemList = repo.itemList
    }
    
    func getItems(){
        repo.getItems()
    }

    func getUserInfo(vc: UIViewController){
        repo.getUserInfo(vc: vc)
    }
    
}
