//
//  MessageCell.swift
//  ParseChat
//
//  Created by Melissa Phuong Nguyen on 2/22/18.
//  Copyright © 2018 Melissa Phuong Nguyen. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {


    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
