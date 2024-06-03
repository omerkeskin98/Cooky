//
//  CartVM.swift
//  Cooky
//
//  Created by Omer Keskin on 27.05.2024.
//

import Foundation
import RxSwift
import Alamofire

class CartVM{
    
    var itemList = BehaviorSubject<[SepetYemekler]>(value: [SepetYemekler]())
    var repo = Repository()
    
    
    func showCart(kullanici_adi: String, completion: @escaping ([SepetYemekler]) -> Void){
        repo.showCart(kullanici_adi: kullanici_adi) { sepetYemeklerListesi in
            // showCart fonksiyonu tamamlandığında, completion closure'ını çağır ve verileri geç
            completion(sepetYemeklerListesi)
        }
    }

    
 
    func addToCart(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String){
        repo.addToCart(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
    }
    
    func removeFromCart(sepet_yemek_id: Int, kullanici_adi: String){
        repo.removeFromCart(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
    func getItems(){
        repo.getItems()
    }

}
