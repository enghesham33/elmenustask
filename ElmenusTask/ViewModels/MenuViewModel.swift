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
    let tagsSubject = BehaviorSubject(value: [Tag]())
    let itemsSubject = BehaviorSubject(value: [Item]())
    
    public init(repository: MenuRepository) {
        self.repository = repository
    }
    
    // MARK: - Actions
    func loadTagsPage(page: String) {
        UiHelpers.showLoader()
        repository.getTags(page: page)
            .subscribe(onNext: { [weak self] tags in
                    self?.tagsSubject.onNext(tags)
                UiHelpers.hideLoader()
                }, onError: { [weak self] error in
                    self?.tagsSubject.onError(error)
                    UiHelpers.hideLoader()
            }).disposed(by: disposeBag)
    }
    
    func tagsObservable() -> Observable<[Tag]> {
        return tagsSubject.asObservable()
    }
    
    func loadTagItems(tagName: String) {
        UiHelpers.showLoader()
        repository.getItems(tagName: tagName)
            .subscribe(onNext: { [weak self] items in
                self?.itemsSubject.onNext(items)
                UiHelpers.hideLoader()
                }, onError: { [weak self] error in
                    self?.itemsSubject.onError(error)
                    UiHelpers.hideLoader()
            }).disposed(by: disposeBag)
    }
    
    func itemsObservable() -> Observable<[Item]> {
        return itemsSubject.asObservable()
    }
}
