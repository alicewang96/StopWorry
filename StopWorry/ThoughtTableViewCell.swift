//
//  ThoughtTableViewCell.swift
//  StopWorry
//
//  Created by Alice Wang on 5/24/16.
//  Copyright © 2016 Alice Wang. All rights reserved.
//

import UIKit

class ThoughtTableViewCell: UITableViewCell {

    @IBOutlet var Thoughts: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
