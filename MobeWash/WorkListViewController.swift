//
//  WorkListViewController.swift
//  MobeWash
//
//  Created by N/A on 4/21/17.
//
//

import UIKit

class WorkListViewController: UITableViewController {
    var washer = Washer(name:"Chris Zhang");

  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource=self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let work1 = Work(workTitle: "Super Wash", workTime: "3pm,Thursday", workLoc: "9500 Gilman Drive", package: "DayDreams",carPicture:"job1.jpg")
        let work2 = Work(workTitle: "job2", workTime: "5pm,Thursday", workLoc: "9501 Gilman Drive", package: "DayDream",carPicture:"job2.jpg")
        let work3 = Work(workTitle: "job3", workTime: "6pm,Thursday", workLoc: "9501 Gilman Drive", package: "DayDream", carPicture: "job3.jpg")
        washer.addWork(work: work1)
        washer.addWork(work: work2)
        washer.addWork(work: work3)
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
        return washer.workList.count
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
        cell.nameLabel.text = washer.workList[indexPath.row].workTitle
        cell.locationLabel.text = washer.workList[indexPath.row].workLocation
        cell.timeLabel.text = "\(washer.workList[indexPath.row].workTime)"
        cell.thumbnailImageView.image = UIImage(named: washer.workList[indexPath.row].carPicture)
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let work = washer.workList[indexPath.row]
        
        performSegue(withIdentifier: "WorkDetailVC", sender: work)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WorkDetailVC{
            
            if let work =  sender as? Work{
                destination.work = work
            }
        }
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
