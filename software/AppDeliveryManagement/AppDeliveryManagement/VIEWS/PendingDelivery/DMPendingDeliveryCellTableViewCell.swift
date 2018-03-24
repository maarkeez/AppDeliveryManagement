//
//  DMPendingDeliveryCellTableViewCell.swift
//  AppDeliveryManagement
//
//  Created by David Márquez Delgado on 18/3/18.
//  Copyright © 2018 David Márquez Delgado. All rights reserved.
//

import UIKit

class DMPendingDeliveryCellTableViewCell: UITableViewCell {

    @IBOutlet weak var myAdress: UILabel!
    @IBOutlet weak var myDeliveryId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
