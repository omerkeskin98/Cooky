//
//  FavoritesVC.swift
//  Cooky
//
//  Created by Omer Keskin on 27.05.2024.
//

import UIKit

class FavoritesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Cooky"
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = UIColor(named: "color1")
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "textColor2")!, .font: UIFont(name: "Pacifico-Regular", size: 27)!]
 
        
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        
    }
    


}
