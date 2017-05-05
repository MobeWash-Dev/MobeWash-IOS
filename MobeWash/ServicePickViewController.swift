//
//  ServicePickViewController.swift
//  MobeWash
//
//  Created by Shuangli Zhou on 4/30/17.
//
//

import UIKit

class ServicePickViewController: UIViewController {
    
    @IBOutlet weak var service_1_button: CustomButton!
    @IBOutlet weak var service_2_button: CustomButton!
    
    @IBOutlet weak var service_display: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func service_1_chosen(_ sender: Any) {
        print("Service 1 chosed")
        self.service_display.text = "Service 1 Chosen"
    }
    
    @IBAction func service_2_chosen(_ sender: Any) {
        print("Service 2 chosed")
        self.service_display.text = "Service 2 Chosen"
    }
    

}
