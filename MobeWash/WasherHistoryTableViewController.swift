//
//  WasherHistoryTableViewController.swift
//  MobeWash
//
//  Created by Z.Z. on 30/04/2017.
//
//

import UIKit

class WasherHistoryTableViewController: UITableViewController {
    var washer = Washer(name:"Eli Qin");
    

    
    var packages:[String] = ["Mobe", "MobePlus", "Mobe"]
    var carType:[String]  = ["Lamborghini Gallardo", "Jeep Grand Cherokee", "McLaren P1"]
    var time:[String] = ["Jan 25th, 15:00", "Jan 26th, 10:00", "Jan 27th, 13:30"]
    var carImages:[String] = ["LG.jpg", "JGC.jpg", "MP.jpg"]
    
    @IBAction func close(segue:UIStoryboardSegue) {
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let work1 = Work(workTitle: "Work 1", workTime: "12pm, Wednesday", workLoc: "9450 Gilman Drive", package: "SuperWash", carInfo: CarInfo(carMake:"Lamborghini", carColor: "Yello", carPlate: "11111", carModel: "Gallardo", carPicture: "LG.jpg", ownerPhone: "1111111111"))
        let work2 = Work(workTitle: "Work 2", workTime: "1pm, Wednesday", workLoc: "9450 Gilman Drive", package: "SuperWash", carInfo: CarInfo(carMake:"Jeep", carColor: "White", carPlate: "22222",carModel: "Grand Cherokee", carPicture: "JGC.jpg", ownerPhone: "2222222222"))
        let work3 = Work(workTitle: "Work 3", workTime: "11am, Saturday", workLoc: "9450 Gilman Drive", package: "SuperWash", carInfo: CarInfo(carMake:"McLaren", carColor: "Blue", carPlate: "33333",carModel: "P1", carPicture: "MP.jpg", ownerPhone: "3333333333"))
        
        washer.addWork(work: work1);
        washer.addWork(work: work2);
        washer.addWork(work: work3);
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
        
        let radius:CGFloat = 30.0
        
        let cellIdentifier = "HistoryCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! WasherHistoryTableViewCell
        
        let work = washer.workList[indexPath.row]
        cell.packageLabel.text = work.package
        cell.carTypeLabel.text = work.carInfo.carMake + " " + work.carInfo.carModel
        cell.dateLabel.text = work.workTime
        cell.thumbnailImageView.image = UIImage(named: work.carInfo.carPicture)
        
        cell.thumbnailImageView.layer.cornerRadius = radius
        cell.thumbnailImageView.clipsToBounds = true
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let work = washer.workList[indexPath.row]
        
        performSegue(withIdentifier: "WorkHistoryDetailViewController", sender: work)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WasherHistoryDetailViewController {
            if let work = sender as? Work {
                destination.work = work
            }
        }
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
