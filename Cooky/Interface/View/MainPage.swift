//
//  ViewController.swift
//  Cooky
//
//  Created by Omer Keskin on 22.05.2024.
//

import UIKit
import Kingfisher
import Firebase
import FirebaseFirestore
import RxSwift
import RxCocoa
import RxRelay

class MainPage: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let firestoreDB = Firestore.firestore()
    var foodList = [Yemekler]()
    var mainPageVM = MainPageVM()
    let disposeBag = DisposeBag()
    var counters: [Counter] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // navigation bar attributes
        self.navigationItem.title = "Cooky"
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(named: "color1")
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "textColor2")!, .font: UIFont(name: "Pacifico-Regular", size: 27)!]
 
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        
        // CollectionView attributes
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        design.minimumInteritemSpacing = 3
        design.minimumLineSpacing = 3
        let ekranGenislik = UIScreen.main.bounds.width
        let itemGenislik = (ekranGenislik-16) / 3
        design.itemSize = CGSize(width: itemGenislik, height: itemGenislik * 1.5)
        collectionView.collectionViewLayout = design
        
        
        
        
       _ = mainPageVM.itemList.subscribe(onNext: {list in
            self.foodList = list
           
           self.counters = list.map { item in
               let counter = Counter()
               let key = "itemCartAmount_\(item.yemek_adi!)"
               if let savedAmount = UserDefaults.standard.value(forKey: key) as? Int {
                   counter.itemCartAmount.accept(savedAmount)
               }
               return counter
           }
            
            DispatchQueue.main.async{
            
                self.collectionView.reloadData()
            }
        })
        
        
        mainPageVM.getItems()
        
        mainPageVM.firestoreUserInfo() // firebase user subscription

    }
    

    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "foodCell", for: indexPath) as! FoodCell
        let item = foodList[indexPath.row]
        cell.itemNameLabel.text = item.yemek_adi
        cell.itemPriceLabel.text = "\(item.yemek_fiyat!)₺"

        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(item.yemek_resim_adi!)"){
            DispatchQueue.main.async {
                cell.imageView.kf.setImage(with: url)
            }
            
        }
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor(named: "textColor1")?.cgColor
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC"{
            if let indexPath = collectionView.indexPathsForSelectedItems?.first{
                let selectedItem = foodList[indexPath.row]
                let selectedCounter = counters[indexPath.row]
                
                if let navController = segue.destination as? UINavigationController,
                   let destinationVC = navController.topViewController as? DetailVC{
                    destinationVC.foodList = selectedItem
                    destinationVC.counter = selectedCounter
                }else if let destinationVC = segue.destination as? DetailVC{
                    destinationVC.foodList = selectedItem
                    destinationVC.counter = selectedCounter
                }
                
            }
        }
    }
    
    func indexPathForCellContaining(_ sender: Any) -> IndexPath? {
        if let button = sender as? UIButton, let cell = button.superview?.superview as? UICollectionViewCell {
            return collectionView.indexPath(for: cell)
        }
        return nil
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toDetailVC", sender: self)
    }
    
    
}

