//
//  TableViewCell.swift
//  Kyotohack
//
//  Created by Marcia on 2016/11/13.
//  Copyright © 2016年 Tomoki Nishinaka. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var number: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var date: UILabel!
  
    @IBOutlet weak var btn: UIButton!
        
        
        
        
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
