//
//  LocalTag.swift
//  ElmenusTask
//
//  Created by Hesham Donia on 7/30/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation
import RealmSwift

public class LocalTag: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var tagName: String = ""
    @objc dynamic var photoURL: String = ""
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    class func incrementaID() -> Int{
        let realm = try! Realm()
        if let retNext = realm.objects(LocalTag.self).sorted(byKeyPath: "id").last?.id {
            return retNext + 1
        }else{
            return 1
        }
    }
    
    class func getInstance(tagName: String, photoURL: String) -> LocalTag {
        let localTag = LocalTag()
        localTag.id = incrementaID()
        localTag.tagName = tagName
        localTag.photoURL = photoURL
        return localTag
    }
    
    public static func deleteAllTags() {
        let realm = try! Realm()
        do {
            try realm.write {
                realm.delete(realm.objects(LocalTag.self))
            }
        } catch (let error) {
            print(error)
        }
    }
    
    class func insertTag(localTag: LocalTag) {
        if !checkTagExist(tagName: localTag.tagName) {
            let realm = try! Realm()
            realm.beginWrite()
            realm.add(localTag)
            try! realm.commitWrite()
        }
    }
    
    class func getAllSavedTags() -> [LocalTag] {
        let realm = try! Realm()
        let results = realm.objects(LocalTag.self)
        return Array(results)
    }
    
    class func updateRepository(localTag: LocalTag) {
        let realm = try! Realm()
        if localTag.id > 0 {
            realm.beginWrite()
            realm.add(localTag, update: Realm.UpdatePolicy.modified)
            try! realm.commitWrite()
        }
    }
    
    class func checkTagExist(tagName: String) -> Bool {
        let allTags = getAllSavedTags()
        for tag in allTags {
            if tag.tagName == tagName {
                return true
            }
        }
        
        return false
    }
}
