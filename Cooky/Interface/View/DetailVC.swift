//
//  DetailVC.swift
//  Cooky
//
//  Created by Omer Keskin on 27.05.2024.
//

import UIKit
import Kingfisher
import RxSwift
import Firebase
import Alamofire
import RxRelay


class DetailVC: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    
    var foodList : Yemekler?
    var cartVM = CartVM()
    var cartVC : CartVC?
    var cartArray = [SepetYemekler]()
    var counter = Counter()
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Detail"
        
        let customFont = UIFont(name: "Verdana-Bold", size: 25.0)
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(named: "textColor1")
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "textColor2")!, NSAttributedString.Key.font: customFont!]
        
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        
        
        counter.itemCartAmount
            .map { "\($0)" }
            .bind(to: amountLabel.rx.text)
            .disposed(by: disposeBag)

        counter.totalPrice
            .map { "\($0)₺" }
            .bind(to: sumLabel.rx.text)
            .disposed(by: disposeBag)
     
        if let item = foodList{
            
            nameLabel.text = item.yemek_adi
            priceLabel.text = "\(item.yemek_fiyat!)₺"
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(item.yemek_resim_adi!)"){
                DispatchQueue.main.async {
                    self.imageView.kf.setImage(with: url)
                }
            }

            
        }
        
        sumLabel.text = "0₺"
        
        if let foodName = foodList?.yemek_adi {
            let key = "itemCartAmount_\(foodName)"
            let totalPriceKey = "totalPrice_\(foodName)"
            if let savedAmount = UserDefaults.standard.value(forKey: key) as? Int {
                counter.itemCartAmount.accept(savedAmount)
            }
            if let savedTotalPrice = UserDefaults.standard.value(forKey: totalPriceKey) as? Int {
                counter.totalPrice.accept(savedTotalPrice)
            }
        }
    }
    
    
    

    private func saveCounterValue() {
        if let foodName = foodList?.yemek_adi {
            let key = "itemCartAmount_\(foodName)"
            let totalPriceKey = "totalPrice_\(foodName)"
            UserDefaults.standard.setValue(counter.itemCartAmount.value, forKey: key)
            UserDefaults.standard.setValue(counter.totalPrice.value, forKey: totalPriceKey)
        }
    }
    
    
    

    @IBAction func decrementClicked(_ sender: Any) {
        
    
        guard counter.itemCartAmount.value > 0 else { return }
        

        // Sepet işlemleri
        if let food = self.foodList, let user = Auth.auth().currentUser?.email, let yemekFiyat = foodList?.yemek_fiyat {
            
            counter.decrement(price: Int(yemekFiyat)!)
            saveCounterValue()
            
            // Önce mevcut öğeyi sil
            self.cartVM.showCart(kullanici_adi: user) { [weak self] cartList in
                guard let self = self else { return }
                self.cartArray = cartList
                
                // sepeet boşsa
                if cartList.isEmpty {
                    print("Sepette öğe bulunamadı veya hata alındı.")
                    return // Hiçbir işlem yapma
                }
                else{
                    
                    // sepet doluysa
                    if let existingItem = cartList.first(where: { $0.yemek_adi == food.yemek_adi! }), let itemID = existingItem.sepet_yemek_id {
                        self.cartVM.removeFromCart(sepet_yemek_id: Int(itemID)!, kullanici_adi: user)
                        
                        // Yeni miktar 0 ise sepetten tamamen kaldır, değilse yeni miktarla tekrar ekle
                        if self.counter.itemCartAmount.value > 0 {
                            self.cartVM.addToCart(yemek_adi: food.yemek_adi!, yemek_resim_adi: food.yemek_resim_adi!, yemek_fiyat: Int(yemekFiyat)!, yemek_siparis_adet: self.counter.itemCartAmount.value, kullanici_adi: user)
                            
                            print("Detaydan sepete eklendi")
                        } else {
                            print("Ürün sepetten tamamen kaldırıldı")
                        }
                        NotificationCenter.default.post(name: .cartUpdated, object: nil)
                    }
                }
            }
        }
    }
 

    
    
    
    @IBAction func incrementClicked(_ sender: Any) {
    
    
        if let food = self.foodList,
           let user = Auth.auth().currentUser?.email,
           let yemekFiyat = foodList?.yemek_fiyat {
            
            counter.increment(price: Int(yemekFiyat)!)
            saveCounterValue()
            
            // Öncelikle ürünü sepete ekle
            self.cartVM.addToCart(yemek_adi: "\(food.yemek_adi!)", yemek_resim_adi: "\(food.yemek_resim_adi!)", yemek_fiyat: Int(yemekFiyat)!, yemek_siparis_adet: Int(self.counter.itemCartAmount.value), kullanici_adi: user)
            print("detaydan sepete eklendi")
                
                // Ürünü ekledikten sonra güncel sepeti al
                self.cartVM.showCart(kullanici_adi: user) { cartList in
                    self.cartArray = cartList
                    
                    // Aynı isimde başka ürün var mı kontrol et
                    if let existingItem = cartList.first(where: { $0.yemek_adi == food.yemek_adi! }) {
                        if let itemID = existingItem.sepet_yemek_id {
                            print("Aynı isimdeki ürün silindi: \(itemID)")
                            self.cartVM.removeFromCart(sepet_yemek_id: Int(itemID)!, kullanici_adi: user)
                        
                        }
                     //   self.sumLabel.text = "\(self.counter.itemCartAmount.value * Int(yemekFiyat)!)₺"
                        NotificationCenter.default.post(name: .cartUpdated, object: nil)
                    }
                    
                }
            }
         
    }
   
    

    
    func itemCartAmountKey(for indexPath: IndexPath) -> String {
        return "itemCartAmount_\(indexPath.section)_\(indexPath.row)"
    }
    
    
}

extension Notification.Name {
    static let cartUpdate = Notification.Name("cartUpdate")
}
