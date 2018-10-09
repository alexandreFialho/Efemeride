//
//  DatasTableViewCell.swift
//  Efemeride
//
//  Created by STR on 09/10/18.
//  Copyright © 2018 STR. All rights reserved.
//

import UIKit

class DatasTableViewCell: UITableViewCell {

    @IBOutlet weak var evento: UILabel!
    @IBOutlet weak var data: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
