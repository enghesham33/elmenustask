//
//  ItemsTableViewCell.swift
//  ElmenusTask
//
//  Created by Hesham Donia on 7/29/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import UIKit
import AlamofireImage

class ItemsTableViewCell: UITableViewCell {

    public static let identifier = "ItemsTableViewCell"

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    public var item: Item!
    
    public func populateData() {
        itemNameLabel.text = item.name
        if let url = URL(string: item.photoURL) {
            itemImageView.af_setImage(withURL: url)
        }
    }
    
    override func prepareForReuse() {
        itemImageView.image = nil
    }
    
}
