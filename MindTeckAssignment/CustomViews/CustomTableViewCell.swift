//
//  CustomTableViewCell.swift
//  MindTeckAssignment
//
//  Created by raushan on 13/10/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    @IBOutlet weak var cellLabelView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
