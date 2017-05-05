//
//  ServicePickViewController.swift
//  MobeWash
//
//  Created by Shuangli Zhou on 4/30/17.
//
//

import UIKit

class ServicePickViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var serviceTable: UITableView!
    @IBOutlet weak var serviceDisplay: UILabel!
    var services = ["MobeWash", "MobePlus", "MobeWhatever"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        serviceTable.delegate = self
        serviceTable.dataSource = self
        
        
        
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
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let serviceCell = tableView.dequeueReusableCell( withIdentifier:"serviceCell") as? serviceCell!
        print("Name is " + services[indexPath.row])
        serviceCell?.serviceButton.setTitle(services[indexPath.row], for: UIControlState.normal)
        
        // customize sercvie button action below later
  
        
        return serviceCell!
        
   
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    


}
