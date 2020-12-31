//
//  GroceryCell.swift
//  Recipe App
//
//  Created by Jasen Castillo on 10/5/20.
//  Copyright © 2020 CSUFTitan. All rights reserved.
//

import UIKit

protocol buttonChange {
    func buttonChange(checked: Bool, index: Int)
}

class GroceryCell: UITableViewCell {
    var delegate: buttonChange?
    var indexP: Int?
    var groceries: [Grocery]?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet var checkBox: UIButton!
    @IBOutlet var groceryList: UILabel!

    @IBAction func checked(_ sender: Any) {
        if groceries![indexP!].checked {
            delegate?.buttonChange(checked: false, index: indexP!)
        } else {
            delegate?.buttonChange(checked: true, index: indexP!)
        }
    }
}
