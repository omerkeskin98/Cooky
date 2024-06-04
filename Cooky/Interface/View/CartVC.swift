//
//  CartVC.swift
//  Cooky
//
//  Created by Omer Keskin on 27.05.2024.
//

import UIKit
import Firebase
import RxSwift
import Kingfisher

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    

    @IBOutlet weak var totalLabel: UILabel!
    
    var cartList = [SepetYemekler]()
    var cartVM = CartVM()
    var disposeBag = DisposeBag()
    var mainPageVM = MainPageVM()
    var detailVC = DetailVC()
    var counter = Counter()
    

    @IBOutlet weak var tableViewCell: CartTVCell!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     

        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationItem.title = "Cooky"
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(named: "color1")
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "textColor2")!, .font: UIFont(name: "Pacifico-Regular", size: 27)!]
 
        
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        
        
        cartVM.itemList
            .subscribe(onNext: { [weak self] list in
                guard let self = self else { return }
                self.cartList = list
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
     
        NotificationCenter.default.addObserver(self, selector: #selector(handleCartUpdateNotification), name: .cartUpdated, object: nil)
        
        loadCartData()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
                loadCartData()
        
    }
    
    
    @objc func handleCartUpdateNotification(notification: Notification) {
        loadCartData()
    }
    
 

    
    func loadCartData() {
        if let user = Auth.auth().currentUser?.email {
            self.cartVM.showCart(kullanici_adi: user) { [weak self] cartList in
                self?.cartList = cartList
                self?.tableView.reloadData()
            }
        }
    }
    deinit {
            NotificationCenter.default.removeObserver(self, name: .cartUpdated, object: nil)
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cartList.isEmpty == true {
            return 0
        } else {
            // Sepet dolu ise gerçek öğe sayısını döndürür
            return cartList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartTVCell
        let item = cartList[indexPath.row]
        cell.selectionStyle = .none
        cell.cellNameLabel.text = item.yemek_adi
        cell.cellPriceLabel.text = "\(item.yemek_fiyat!)₺"
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(item.yemek_resim_adi!)"){
            DispatchQueue.main.async {
                cell.cellImage.kf.setImage(with: url)
            }
        }
        cell.cellAmountLabel.text = "\(item.yemek_siparis_adet!) adet"
        cell.cellSumLabel.text = "\(Int(item.yemek_siparis_adet!)! * Int(item.yemek_fiyat!)!)₺"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }


    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, bool in
        let item = self.cartList[indexPath.row]
            let alert = UIAlertController(title: "Delete", message: "Do you want to delete the \(item.yemek_adi!)?", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            let yesAction = UIAlertAction(title: "Delete", style: .destructive){ [self]_ in
                if let user = Auth.auth().currentUser?.email{
                    self.cartVM.removeFromCart(sepet_yemek_id: Int(item.sepet_yemek_id!)!, kullanici_adi: user)
                    self.cartVM.showCart(kullanici_adi: user) { [weak self] cartList in

                        self?.cartList = cartList
                        tableView.reloadData()
                
                    }
                }
            
            }
            
            alert.addAction(yesAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    

    


}


extension Notification.Name {
    static let cartUpdated = Notification.Name("cartUpdated")
}

