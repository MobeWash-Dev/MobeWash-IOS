//
//  PickAServiceViewController.swift
//  MobeWash
//
//  Created by Jiawei He on 5/26/17.
//  Copyright © 2017 MobeWash. All rights reserved.
//

import UIKit

class PickAServiceViewController: UIViewController {

    @IBOutlet weak var MobeWashOptionViewOutlet: UIView!
    @IBOutlet weak var MobePlusOptionViewOutlet: UIView!
    @IBOutlet weak var MobeWashOptionButtonOutlet: UIButton!
    
    @IBOutlet weak var MobePlusOptionButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MobeWashOptionViewOutlet.layer.cornerRadius = 5
        MobePlusOptionViewOutlet.layer.cornerRadius = 5
        MobeWashOptionButtonOutlet.layer.cornerRadius = 5
        MobePlusOptionButtonOutlet.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
