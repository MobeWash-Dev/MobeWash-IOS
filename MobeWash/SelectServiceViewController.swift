//
//  ServicePickViewController.swift
//  MobeWash
//
//  Created by Shuangli Zhou on 4/30/17.
//
//

import UIKit

class SelectServiceViewController: UIViewController {
    @IBOutlet weak var serviceTableView: UITableView!
    @IBOutlet weak var serviceLabel: UILabel!
    
    var services = ["MobeWash", "MobePlus", "MobeWhatever"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceTableView.delegate = self
        serviceTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

extension SelectServiceViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ServiceTableViewCell = tableView.dequeueReusableCell( withIdentifier:"ServiceTableViewCell") as? ServiceTableViewCell!
        
        ServiceTableViewCell?.serviceButton.setTitle(services[indexPath.row], for: UIControlState.normal)

        return ServiceTableViewCell!
    }
}
