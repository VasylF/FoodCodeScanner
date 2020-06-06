//
//  FCSPriceListViewController.swift
//  FoodCodeScanner
//
//  Created by Vasyl Fuchenko on 6/5/20.
//  Copyright © 2020 Vasyl Fuchenko. All rights reserved.
//

import UIKit

class FCSPriceListViewController: UIViewController {
    @IBOutlet private weak var productImage: UIImageView!
    @IBOutlet private weak var priceName: UILabel!
    @IBOutlet private weak var priceListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceListTableView.register(cell: FCSPriceListTableViewCell.self)
        configureUI()
    }
    
    private func configureUI() {
        productImage.layer.cornerRadius = 10
    }
}

extension FCSPriceListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FCSPriceListTableViewCell = priceListTableView.dequeueReusableCell(for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}
