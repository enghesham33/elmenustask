//
//  MenuViewModel.swift
//  ElmenusTask
//
//  Created by Hesham Donia on 7/29/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import Foundation
import RxSwift

public class MenuViewModel {
    
    private var repository: MenuRepository!
    let disposeBag = DisposeBag()
    let tagsSubject = PublishSubject<[Tag]>()//BehaviorSubject(value: [Tag]())
    let itemsSubject = PublishSubject<[Item]>()
    
    public init(repository: MenuRepository) {
        self.repository = repository
    }
    
    // MARK: - Actions
    func loadTagsPage(page: String) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            repository.getTags(page: page)
                .subscribe(onNext: { [weak self] tags in
                    self?.tagsSubject.onNext(tags)
                    UiHelpers.hideLoader()
                    }, onError: { [weak self] error in
                        self?.tagsSubject.onError(error)
                        UiHelpers.hideLoader()
                }).disposed(by: disposeBag)
        } else if page == "1" { // to load all tags once
            let localTags = LocalTag.getAllSavedTags()
            tagsSubject.onNext(localTags.map({ (localTag) -> Tag in
                Tag(tagName: localTag.tagName, photoURL: localTag.photoURL)
            }))
        }
        
    }
    
    func tagsObservable() -> Observable<[Tag]> {
        return tagsSubject.asObservable()
    }
    
    func loadTagItems(tagName: String) {
        if UiHelpers.isInternetAvailable() {
            UiHelpers.showLoader()
            repository.getItems(tagName: tagName)
                .subscribe(onNext: { [weak self] items in
                    self?.itemsSubject.onNext(items)
                    UiHelpers.hideLoader()
                    }, onError: { [weak self] error in
                        self?.itemsSubject.onError(error)
                        UiHelpers.hideLoader()
                }).disposed(by: disposeBag)
        } else {
            let localItems = LocalItem.getTagItems(tagName: tagName)
            itemsSubject.onNext(localItems.map({ (localItem) -> Item in
                Item(id: localItem.id, name: localItem.name, photoURL: localItem.photoURL, itemDesc: localItem.itemDesc)
            }))
        }
        
    }
    
    func itemsObservable() -> Observable<[Item]> {
        return itemsSubject.asObservable()
    }
}
