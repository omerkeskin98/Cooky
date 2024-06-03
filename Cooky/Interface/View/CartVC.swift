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

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var cartList = [SepetYemekler]()
    var cartVM = CartVM()
    var disposeBag = DisposeBag()

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
        
            
        if let user = Auth.auth().currentUser?.email {
            self.cartVM.showCart(kullanici_adi: user) { [weak self] cartList in
 
                self?.cartList = cartList
                self?.tableView.reloadData()
            }
        }

        
        

        cartVM.itemList
            .subscribe(onNext: { [weak self] list in
                guard let self = self else { return }
                self.cartList = list
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
    
      
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            if let user = Auth.auth().currentUser?.email {
                self.cartVM.showCart(kullanici_adi: user) { [weak self] cartList in
     
                    self?.cartList = cartList
                    self?.tableView.reloadData()
                }
            }
            self.tableView.reloadData()
            self.checkIfTableViewIsEmpty()
        }
       
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
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
            
            let iptalAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Delete", style: .destructive){_ in
                self.cartVM.removeFromCart(sepet_yemek_id: Int(item.sepet_yemek_id!)!, kullanici_adi: (Auth.auth().currentUser?.email)!)
                
                if let user = Auth.auth().currentUser?.email {
                    self.cartVM.showCart(kullanici_adi: user) { [weak self] cartList in

                        self?.cartList = cartList
                        self!.checkIfTableViewIsEmpty()
                        self?.tableView.reloadData()
                    
                    }
                }
                
            }
            alert.addAction(evetAction)
            
            self.present(alert, animated: true)
            
            
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    
    func checkIfTableViewIsEmpty() {
        if cartList.isEmpty {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            messageLabel.text = "Cart is empty"
            messageLabel.textColor = .black
            messageLabel.textAlignment = .center
            messageLabel.font = UIFont.systemFont(ofSize: 20)
            messageLabel.sizeToFit()

            tableView.backgroundView = messageLabel
            tableView.separatorStyle = .none
        } else {
            tableView.backgroundView = nil
            tableView.separatorStyle = .singleLine
        }
    }

}
