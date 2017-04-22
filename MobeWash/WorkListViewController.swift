//
//  WorkListViewController.swift
//  MobeWash
//
//  Created by N/A on 4/21/17.
//
//

import UIKit

class WorkListViewController: UITableViewController {
    var workListName = ["Super Wash", "job2", "job3"]
    var workListLocation = ["UTC", "UCSD", "La Jolla"]
    var workListTime = [3, 5, 6]
    var workListImages = ["job1.jpg", "job2.jpg", "job3.jpg"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workListName.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellIdentifier = "Cell"
        var radius:CGFloat = 0
        
        if indexPath.row == 0 {
            cellIdentifier = "priorityCell";
            radius = 0
        }
        else {
            radius = 40
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                  as! WorkListTableViewCell
        cell.nameLabel.text = workListName[indexPath.row]
        cell.locationLabel.text = workListLocation[indexPath.row]
        cell.timeLabel.text = "\(workListTime[indexPath.row]) PM"
        cell.thumbnailImageView.image = UIImage(named: workListImages[indexPath.row])
        cell.thumbnailImageView.layer.cornerRadius = radius
        cell.thumbnailImageView.clipsToBounds = true
        return cell
    }
  
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
      if indexPath.row == 0 {
        return 200
      }
      return 100
    }
    
    func update() {
    
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
