//
//  Repository.swift
//  Cooky
//
//  Created by Omer Keskin on 23.05.2024.
//

import Foundation
import RxSwift
import Kingfisher
import Alamofire
import Firebase
import FirebaseFirestore

class Repository{
    
    var itemList = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    var cartList = BehaviorSubject<[SepetYemekler]>(value: [SepetYemekler]())
    let firestoreDB = Firestore.firestore()
    
    
    

    func addToCart(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php")!
        let params: Parameters = ["yemek_adi": yemek_adi, "yemek_resim_adi": yemek_resim_adi, "yemek_fiyat": yemek_fiyat, "yemek_siparis_adet": yemek_siparis_adet, "kullanici_adi": kullanici_adi]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default).response { response in
            debugPrint(response) // API yanıtını hata ayıklama konsoluna yazdırır
            
            if let data = response.data {
                do {
                    let decodedResponse = try JSONDecoder().decode(CRUDResponse.self, from: data)
                  //  print("Decoded response: \(decodedResponse)")
                    // Yanıtın başarı durumunu ve mesajını işleyin
                } catch {
                    print("JSON decoding error: \(error)")
                    // JSON decoding hatasını işleyin
                }
            } else {
                if let error = response.error {
                    print("Request error: \(error.localizedDescription)")
                    // İstek hatasını işleyin
                } else {
                    print("Unknown error")
                    // Bilinmeyen hatayı işleyin
                }
            }
        }
    }

    
    
   /*/ func addToCart(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String){
 
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php")!
        let params : Parameters = [            "yemek_adi": yemek_adi,
                                               "yemek_resim_adi": yemek_resim_adi,
                                               "yemek_fiyat": yemek_fiyat,
                                               "yemek_siparis_adet": yemek_siparis_adet,
                                               "kullanici_adi": kullanici_adi]
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default).response { response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(CRUDResponse.self, from: data)

                    print("basari: \(response.success!)")
                    print("message: \(response.message!)")
                    
                }catch{
                    print(error.localizedDescription)
                }
                
            
            }
            
        }
    }
    */
    
    func showCart(kullanici_adi: String, completion: @escaping ([SepetYemekler]) -> Void) {
        guard let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php") else {
            print("Invalid URL")
            return
        }
        
        let params: [String: Any] = ["kullanici_adi": kullanici_adi]
        
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default).response { response in
            if let data = response.data {
                do {
                    let response = try JSONDecoder().decode(SepetResponse.self, from: data)
                    if let list = response.sepet_yemekler{
                        self.cartList.onNext(list)
                        print("items added to sepet_yemekler array: \(list)")
                        completion(list) // completion closure çağrılır
                    } else {
                        print("No items found in sepet_yemekler")
                    }
                } catch {
                    print("JSON decoding error: \(error)")
                }
            } else {
                if let error = response.error {
                    print("Request error: \(error.localizedDescription)")
                } else {
                    print("Unknown error")
                }
            }
        }
    }

    
    func removeFromCart(sepet_yemek_id : Int, kullanici_adi : String){
        
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php")!
        let params : [String: Any] = [         "sepet_yemek_id": sepet_yemek_id,
                                               "kullanici_adi": kullanici_adi]
        AF.request(url, method: .post, parameters: params, encoding: URLEncoding.default).response { response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(CRUDResponse.self, from: data)

                    print("basari: \(response.success!)")
                    print("message: \(response.message!)")
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    func getItems(){
        
        let url = URL(string: "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php")!
        AF.request(url, method: .get).response { response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(YemekResponse.self, from: data)
                    if let list = response.yemekler{
                        self.itemList.onNext(list)
                    }
                }catch{
                    print(error.localizedDescription)
                }
                
            
            }
            
        }
        
    }
    
    
    func searchItems(searchWord: String){
        

    }
    
    func addToFavorites(){
        
        
        
    }
    
    
    func getUserInfo(){
        
        firestoreDB.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshot, error) in
            if error != nil{
                let warning = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                warning.addAction(okButton)
                MainPage().present(warning, animated: true, completion: nil)
            }
            else{
                if snapshot?.isEmpty == false && snapshot != nil{
                    for document in snapshot!.documents{
                        if document.get("email") is String{
                            UserSingleton.shareUserInfo.email = Auth.auth().currentUser!.email!
   
                            
                            
                        }
                        
                    }
                    
                }
                
            }
        }
        
    }
    

    func signOutUser(completion: @escaping (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            completion(false)
        }
    }

}
