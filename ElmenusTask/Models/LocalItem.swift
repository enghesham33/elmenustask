//
//  LocalItem.swift
//  ElmenusTask
//
//  Created by Hesham Donia on 7/30/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation
import RealmSwift

public class LocalItem: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var tagName: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var photoURL: String = ""
    @objc dynamic var itemDesc: String = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    class func incrementaID() -> Int{
        let realm = try! Realm()
        if let retNext = realm.objects(LocalItem.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        }else{
            return 1
        }
    }
    
    class func getInstance(tagName: String, name: String, photoURL: String, itemDesc: String) -> LocalItem {
        let localItem = LocalItem()
        localItem.id = incrementaID()
        localItem.name = name
        localItem.tagName = tagName
        localItem.photoURL = photoURL
        localItem.itemDesc = itemDesc
        return localItem
    }
    
    public static func deleteAllItems() {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.delete(realm.objects(LocalItem.self))
            }
        } catch (let error) {
            print(error)
        }
    }
    
    class func insertItem(localItem: LocalItem) {
        if !checkItemExist(tagName: localItem.tagName, itemName: localItem.name) {
            let realm = try! Realm()
            realm.beginWrite()
            realm.add(localItem)
            try! realm.commitWrite()
        }
    }
    
    class func getTagItems(tagName: String) -> [LocalItem] {
        let realm = try! Realm()
        let results = Array(realm.objects(LocalItem.self))
        var filteredItems = [LocalItem]()
        for localItem in results {
            if localItem.tagName == tagName {
                filteredItems.append(localItem)
            }
        }
        return filteredItems
    }
    
    class func updateRepository(localItem: LocalItem) {
        let realm = try! Realm()
        if localItem.id > 0 {
            realm.beginWrite()
            realm.add(localItem, update: Realm.UpdatePolicy.modified)
            try! realm.commitWrite()
        }
    }
    
    class func checkItemExist(tagName: String, itemName: String) -> Bool {
        let allItems = getTagItems(tagName: tagName)
        for item in allItems {
            if item.tagName == tagName && item.name == itemName {
                return true
            }
        }
        
        return false
    }
}
