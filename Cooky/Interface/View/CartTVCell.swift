//
//  CartTVCell.swift
//  Cooky
//
//  Created by Omer Keskin on 1.06.2024.
//

import UIKit
import RxSwift

class CartTVCell: UITableViewCell {
    
    

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellPriceLabel: UILabel!
    @IBOutlet weak var cellAmountLabel: UILabel!
    @IBOutlet weak var cellSumLabel: UILabel!
    
    var counter = Counter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
