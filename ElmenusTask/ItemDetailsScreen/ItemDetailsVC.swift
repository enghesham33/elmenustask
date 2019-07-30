//
//  ItemDetailsVC.swift
//  ElmenusTask
//
//  Created by Hesham Donia on 7/29/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import UIKit
import AlamofireImage
import Hero

class ItemDetailsVC: BaseVC {
    
    var item: Item!
    @IBOutlet weak var itemPhotoImageView: UIImageView!
    @IBOutlet weak var itemDescribtionLabel: UILabel!
    @IBOutlet weak var closeImageView: UIImageView!
    
    public static func buildVC(item: Item) -> ItemDetailsVC {
        let storyboard = UIStoryboard(name: "ItemDetailsStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
        vc.item = item
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hero.isEnabled = true
        itemPhotoImageView.hero.id = "itemImageView"
        self.view.hero.modifiers = [.translate(y:100)]
        
        if let url = URL(string: item.photoURL) {
            itemPhotoImageView.af_setImage(withURL: url)
        }
        
        itemDescribtionLabel.text = item.itemDesc
        closeImageView.addTapGesture { (_) in
            self.dismissVC(completion: nil)
        }
    }

}
