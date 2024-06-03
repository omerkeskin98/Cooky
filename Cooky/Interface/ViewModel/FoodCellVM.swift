//
//  FoodCellVM.swift
//  Cooky
//
//  Created by Omer Keskin on 30.05.2024.
//

import Foundation
import RxSwift

class FoodCellVM{
    
    var itemList = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    var repo = Repository()
    
}
