//
//  ViewController.swift
//  MobeWash
//
//  Created by Sean Ippolito on 4/16/17.
//
//

import UIKit

class HomeViewController: UIViewController {

    @IBAction func onPressedWorklist(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Worklist", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "InitialController") as UIViewController
        self.present(controller, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSLog("For testing purpose only.")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

