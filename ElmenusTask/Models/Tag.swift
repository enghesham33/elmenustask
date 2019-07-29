//
//  Tag.swift
//  ElmenusTask
//
//  Created by Hesham Donia on 7/29/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation

public struct Tag {
    
    let tagName: String
    let photoURL: String
    
    public static func parse(json: Dictionary<String, Any>) -> Tag {
        return Tag(tagName: json["tagName"] as? String ?? "", photoURL: json["photoURL"] as? String ?? "")
    }
}
