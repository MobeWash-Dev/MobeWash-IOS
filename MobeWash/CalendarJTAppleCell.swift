//
//  CalendarJTAppleCell.swift
//  MobeWash
//
//  Created by Sean Ippolito on 5/3/17.
//
//

import UIKit
import JTAppleCalendar

class CalendarJTAppleCell: JTAppleCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var strikeThrough: UILabel!
    @IBOutlet weak var selectedView: UIView!

    var isCurrentDate: Bool = false
}
