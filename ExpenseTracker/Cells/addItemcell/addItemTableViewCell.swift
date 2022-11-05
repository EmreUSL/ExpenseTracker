//
//  addItemTableViewCell.swift
//  ExpenseTracker
//
//  Created by emre usul on 21.10.2022.
//

import UIKit

class addItemTableViewCell: UITableViewCell {

    @IBOutlet weak var addItemLabel: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var addItemImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
