//
//  WasherHistoryTableViewCell.swift
//  MobeWash
//
//  Created by Z.Z. on 30/04/2017.
//
//

import UIKit

class WasherHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet var packageLabel:UILabel!
    @IBOutlet var carTypeLabel:UILabel!
    @IBOutlet var dateLabel:UILabel!
    @IBOutlet var thumbnailImageView:UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
