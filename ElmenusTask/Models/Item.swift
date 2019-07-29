//
//  Item.swift
//  ElmenusTask
//
//  Created by Hesham Donia on 7/29/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation

public struct Item {
    
    let id: Int
    let name: String
    let photoURL: String
    let description: String
    
    public static func parse(json: Dictionary<String, Any>) -> Item {
        return Item(id: json["id"] as? Int ?? 0, name: json["name"] as? String ?? "", photoURL: json["photoUrl"] as? String ?? "", description: json["description"] as? String ?? "")
    }
}
