//
//  Navigator.swift
//  ElmenusTask
//
//  Created by Hesham Donia on 7/21/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation
import UIKit

public class Navigator {
    
    var navigationController: UINavigationController!
    
    public init(navController: UINavigationController) {
        self.navigationController = navController
    }
    
    public func navigateToItemDetails(item: Item) {
        let vc = ItemDetailsVC.buildVC(item: item)
        vc.hero.isEnabled = true
        self.navigationController.presentVC(vc)
//        self.navigationController.pushViewController(vc, animated: true)
    }
}
