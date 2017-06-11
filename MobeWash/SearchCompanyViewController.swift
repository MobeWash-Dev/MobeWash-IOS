//
//  SearchCompanyViewController.swift
//  MobeWash
//
//  Created by Chad Lohrli on 6/10/17.
//  Copyright © 2017 MobeWash. All rights reserved.
//

import Foundation
import UIKit

class SearchCompanyViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
}
