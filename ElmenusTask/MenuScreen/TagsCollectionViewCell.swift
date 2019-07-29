//
//  TagsCollectionViewCell.swift
//  ElmenusTask
//
//  Created by Hesham Donia on 7/29/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import UIKit
import AlamofireImage

class TagsCollectionViewCell: UICollectionViewCell {
 
     public static let identifier = "TagsCollectionViewCell"
    
    @IBOutlet weak var tagImageView: UIImageView!
    @IBOutlet weak var tagNameLabel: UILabel!
    
    public var menuTag: Tag!
    
    public func populateData() {
        tagNameLabel.text = menuTag.tagName
        if let url = URL(string: menuTag.photoURL) {
            tagImageView.af_setImage(withURL: url)
        }
    }
    
    override func prepareForReuse() {
        tagImageView.image = nil
    }
}
