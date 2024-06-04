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
    
    let totalPrice = BehaviorRelay<Int>(value: 0)
    
    
    func increment(price:Int) {
        itemCartAmount.accept(itemCartAmount.value + 1)
        updateTotalPrice(price: price)
    }
    
    func decrement(price:Int) {
        let currentAmount = itemCartAmount.value
        if currentAmount > 0 {
            itemCartAmount.accept(currentAmount - 1)
            updateTotalPrice(price: price)
        }
    }
    
    private func updateTotalPrice(price: Int) {
        let newTotalPrice = Int(itemCartAmount.value) * price
        totalPrice.accept(newTotalPrice)
    }
    
    
}
