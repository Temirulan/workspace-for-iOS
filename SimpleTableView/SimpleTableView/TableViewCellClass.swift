//
//  TableViewCellClass.swift
//  
//
//  Created by Mussayev Temirulan Zamirbekovich on 4/20/15.
//
//

import UIKit

class TableViewCellClass: UITableViewCell {

    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
