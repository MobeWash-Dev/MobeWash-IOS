//
//  Ready2BookViewController.swift
//  MobeWash
//
//  Created by Shuangli Zhou on 4/27/17.
//
//

import UIKit

class Ready2BookViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var companyInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        companyInput.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
