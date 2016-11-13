//
//  ProfessorTableViewCell.swift
//  Kyotohack
//
//  Created by Tomoki Nishinaka on 2016/11/13.
//  Copyright © 2016年 Tomoki Nishinaka. All rights reserved.
//

import UIKit

class ProfessorTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var room: UILabel!


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
