//
//  WorkDetailVC.swift
//  MobeWash
//
//  Created by 张子桐 on 4/22/17.
//
//

import UIKit
import MapKit
import CoreLocation

class WorkDetailVC: UITableViewController,MKMapViewDelegate,CLLocationManagerDelegate{
    private var _work:Work!
    
    @IBOutlet weak var WorkTime: UILabel!
    
    @IBOutlet weak var workType: UILabel!

    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var carPlate: UILabel!
    
    @IBOutlet weak var carMake: UILabel!
    
    @IBOutlet weak var carModel: UILabel!
    
    @IBOutlet weak var carColor: UIView!
    
    @IBOutlet weak var Phone: UILabel!
    
    @IBOutlet weak var carImage: UIImageView!

    
    @IBOutlet weak var locationCell: UITableViewCell!
    
    @IBOutlet weak var phoneCell: UITableViewCell!
    
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
        carImage.image=UIImage(named: _work.carInfo.carPicture)
        location.text = _work.workLocation
        WorkTime.text = _work.workTime
        workType.text = _work.package
        carMake.text = _work.carInfo.carMake
        carModel.text = _work.carInfo.carModel
        carPlate.text = _work.carInfo.carPlate
        switch work.carInfo.carColor {
        case "white":
            carColor.backgroundColor = UIColor.white
            break
        case "blue":
            carColor.backgroundColor = UIColor.blue
            break
        case "yellow":
            carColor.backgroundColor=UIColor.yellow
            break
        default:
            carColor.backgroundColor = UIColor.black
            break
        }
        Phone.text = work.carInfo.ownerPhone
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //when click location cell
        let locationIndex = tableView.indexPath(for: self.locationCell)
        if (locationIndex == indexPath){
            gotoMap()
            
        }
        let phoneIndex = tableView.indexPath(for: self.phoneCell)
        if (phoneIndex == indexPath){
            let telephoneURL:NSURL = URL(string: "TEL://\(work.carInfo.ownerPhone)")! as NSURL
            UIApplication.shared.open(telephoneURL as URL,options:[:],completionHandler:nil)
        }
        
    }
    func gotoMap(){
        let currentLocationMapItem:MKMapItem = MKMapItem.forCurrentLocation()
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(work.workLocation, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let desPlacemark = placemarks![0]
                    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                    let addressDict = desPlacemark.addressDictionary
                    let coordinate = desPlacemark.location?.coordinate
                    let mkPlacemark = MKPlacemark(coordinate: coordinate!, addressDictionary: addressDict as! [String : Any])
                    
                    let mapItem = MKMapItem(placemark:mkPlacemark)
                    MKMapItem.openMaps(with: [currentLocationMapItem, mapItem], launchOptions: launchOptions)

                }
        })



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
