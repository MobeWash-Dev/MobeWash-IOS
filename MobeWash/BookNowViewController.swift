//
//  BookNowViewController.swift
//  MobeWash
//
//  Created by Jiawei He on 5/26/17.
//  Copyright © 2017 MobeWash. All rights reserved.
//

import UIKit

class BookNowViewController: UIViewController {
    
    @IBOutlet weak var BookNowButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BookNowButtonOutlet.layer.borderWidth = 2
        BookNowButtonOutlet.layer.borderColor = UIColor(red: 56/255, green: 135/255, blue: 254/255, alpha: 1).cgColor
        BookNowButtonOutlet.layer.cornerRadius = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
