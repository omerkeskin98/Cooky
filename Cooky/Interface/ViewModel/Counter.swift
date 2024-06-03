//
//  Counter.swift
//  Cooky
//
//  Created by Omer Keskin on 2.06.2024.
//

import Foundation
import RxSwift
import RxRelay


class Counter{
    
    let itemCartAmount = BehaviorRelay<Int>(value: 0)
    
    func increment() {
        itemCartAmount.accept(itemCartAmount.value + 1)
    }
    
    func decrement() {
        let currentAmount = itemCartAmount.value
        if currentAmount > 0 {
            itemCartAmount.accept(currentAmount - 1)
        }
    }
    
    
}
