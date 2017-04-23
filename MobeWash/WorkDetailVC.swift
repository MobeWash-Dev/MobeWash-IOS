//
//  WorkDetailVC.swift
//  MobeWash
//
//  Created by 张子桐 on 4/22/17.
//
//

import UIKit

class WorkDetailVC: UIViewController {
    private var _work:Work!
    
    
    @IBOutlet weak var package: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var carDes: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    
    @IBAction func pressedBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    var work:Work{
        get{
            return _work
        }
        set{
            _work = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carImage.image=UIImage(named: _work.carPicture)
        location.text = _work.workLocation
        time.text=_work.workTime
        package.text=_work.package
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

}
