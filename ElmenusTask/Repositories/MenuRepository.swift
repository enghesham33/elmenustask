//
//  MenuRepository.swift
//  ElmenusTask
//
//  Created by Hesham Donia on 7/29/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation
import RxAlamofire
import RxSwift
import Alamofire

public class MenuRepository {
    public func getTags(page: String) -> Observable<[Tag]> {
        let url = CommonConstants.BASE_URL + "tags/" + page
        print(url)
        return RxAlamofire.requestJSON(.get, url , parameters: nil, encoding: URLEncoding.default, headers: ["Content-Type" : "application/json"])
            .map { (response, json) -> [Tag] in
                var tags = [Tag]()
                
                if let dictionary = json as? Dictionary<String, Any> {
                    if let tagsArray = dictionary["tags"] as? [Dictionary<String, Any>] {
                        for tag in tagsArray {
                            let tagObj = Tag.parse(json: tag)
                            tags.append(tagObj)
                            LocalTag.insertTag(localTag: LocalTag.getInstance(tagName: tagObj.tagName, photoURL: tagObj.photoURL))
                        }
                    }
                }
                return tags
        }
    }
    
    public func getItems(tagName: String) -> Observable<[Item]> {
        let url = CommonConstants.BASE_URL + "items/" + tagName
        print(url)
        return RxAlamofire.requestJSON(.get, url , parameters: nil, encoding: URLEncoding.default, headers: ["Content-Type" : "application/json"])
            .map { (response, json) -> [Item] in
                var items = [Item]()
                
                if let dictionary = json as? Dictionary<String, Any> {
                    if let itemsArray = dictionary["items"] as? [Dictionary<String, Any>] {
                        for item in itemsArray {
                            let itemObj = Item.parse(json: item)
                            items.append(itemObj)
                            LocalItem.insertItem(localItem: LocalItem.getInstance(tagName: tagName, name: itemObj.name, photoURL: itemObj.photoURL, itemDesc: itemObj.itemDesc))
                        }
                    }
                }
                return items
        }
    }
}
