//
//  Injector.swift
//  ElmenusTask
//
//  Created by Hesham Donia on 7/21/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation

public class Injector {
    
    public class func provideMenuViewModel() -> MenuViewModel {
        return MenuViewModel(repository: Injector.provideMenuRepository())
        
    }

    public class func provideMenuRepository() -> MenuRepository {
        return MenuRepository()
    }
}
