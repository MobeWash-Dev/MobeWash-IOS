//
//  WashingInProgressViewController.swift
//  MobeWash
//
//  Created by Dongze Li on 5/14/17.
//  Copyright © 2017 MobeWash. All rights reserved.
//

import UIKit

class WashingInProgressViewController: UIViewController, UINavigationControllerDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var washingStepButton: UIButton!
    var carPhotos: [UIImage] = [UIImage(named:"job1.jpg")!, UIImage(named:"job2.jpg")!, UIImage(named:"job3.jpg")!]
    override func viewDidLoad() {
        super.viewDidLoad()
        washingStepButton.setTitle("Take a picture before washing!", for: .normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func WashingSteps(_ sender: Any) {
        if washingStepButton.currentTitle == "Take a picture before washing!" {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carPhotos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoSlidesViewCell
        cell.washingPhotosImageView.image = carPhotos[indexPath.row]
        cell.washingPhotosImageView.contentMode = UIViewContentMode.scaleAspectFill
        cell.washingPhotosImageView.clipsToBounds = true
        return cell
    }
    
    /**** method for changing view after taking the picture before car washing and update the
     relative photo on showslides *****/
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            carPhotos.append(image)
        }
        else {
            print ("Photo Format is Wrong")
        }
        self.dismiss(animated: true, completion: nil)
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
