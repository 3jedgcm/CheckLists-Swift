//
//  ChecklistItemCell.swift
//  Checklists
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 Clément MERLET. All rights reserved.
//

import UIKit

class ChecklistItemCell: UITableViewCell {

    @IBOutlet weak var textNameLabel: UILabel!
    @IBOutlet weak var checkNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
