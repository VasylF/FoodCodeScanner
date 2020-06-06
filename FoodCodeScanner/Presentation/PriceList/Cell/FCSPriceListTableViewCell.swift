//
//  FCSPriceListTableViewCell.swift
//  FoodCodeScanner
//
//  Created by Vasyl Fuchenko on 6/5/20.
//  Copyright © 2020 Vasyl Fuchenko. All rights reserved.
//

import UIKit

class FCSPriceListTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var shopLogo: UIImageView!
    @IBOutlet private weak var shopName: UILabel!
    @IBOutlet private weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    private func configureUI() {
        shopLogo.layer.cornerRadius = shopLogo.frame.height / 2
        
        layer.cornerRadius = 10
//        backgroundColor = .li
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 1.5
    }
}
