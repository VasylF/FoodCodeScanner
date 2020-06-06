//
//  UITableView.swift
//  FoodCodeScanner
//
//  Created by Vasyl Fuchenko on 6/6/20.
//  Copyright © 2020 Vasyl Fuchenko. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cell: T.Type) {
        register(cell.nib, forCellReuseIdentifier: cell.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not find collection view cell with identifier \(T.identifier)")
        }
        return cell
    }
}
