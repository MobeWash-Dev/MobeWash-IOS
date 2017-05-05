//
//  CalendarCell.swift
//  MobeWash
//
//  Created by Sean Ippolito on 5/3/17.
//
//

import UIKit
import JTAppleCalendar

class CalendarCell: JTAppleCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var strikeThrough: UILabel!
    @IBOutlet weak var selectedView: UIView!

    /*
    override var isSelected: Bool {
        didSet {
            self.layer.borderWidth = 3.0
            self.layer.borderColor = isSelected ? UIColor.green.cgColor : UIColor.black.cgColor
        }
    }*/
    
}
