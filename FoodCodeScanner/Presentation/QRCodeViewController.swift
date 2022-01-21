//
//  QRCodeViewController.swift
//  QRCodeReader
//
//  Created by Simon Ng on 13/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    let buuton: Int = 9

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
    @IBAction func scanCodeButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "FCSPriceList", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FCSPriceListViewController")
        self.present(vc, animated: true)
    }
    
}
