//
//  FoodCell.swift
//  Cooky
//
//  Created by Omer Keskin on 30.05.2024.
//

import UIKit
import Kingfisher
import Firebase
import FirebaseFirestore
import RxSwift
import RxCocoa
import RxRelay

class FoodCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var foodList : Yemekler?
    var cartList : SepetYemekler?
    var cartVM = CartVM()
    var cartVC : CartVC?
    var cartArray = [SepetYemekler]()
    let mainPage = MainPageVM()
    

    let disposeBag = DisposeBag()
    var counter = Counter()
    
    
    
    
    
 

}
