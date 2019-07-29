//
//  MenuVC.swift
//  ElmenusTask
//
//  Created by Hesham Donia on 7/29/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import UIKit
import RxSwift
import Toast_Swift

class MenuVC: BaseVC {

    private var tags = [Tag]()
    private var items = [Item]()
    let disposeBag = DisposeBag()
    var nextPage = 1
    
    public static func buildVC() -> MenuVC {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        return vc
    }
    
    private var menuViewModel: MenuViewModel!
    
    @IBOutlet weak var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuTableView.dataSource = self
        self.menuTableView.delegate = self
        
        menuViewModel = Injector.provideMenuViewModel()
        
        self.menuViewModel.itemsObservable()
            .subscribe(onNext: { [weak self] items in
                self?.items.removeAll()
                self?.items.append(contentsOf: items)
                self?.menuTableView.reloadData()
                }, onError: { [weak self] error in
                    self?.view.makeToast(error.localizedDescription)
            }).disposed(by: disposeBag)
        
        menuViewModel.tagsObservable()
            .subscribe(onNext: { [weak self] tags in
                var loadItems = false
                if self?.tags.count == 0 {
                    loadItems = true
                }
                self?.tags.append(contentsOf: tags)
                if loadItems {
                    var tagName = self?.tags.get(0)?.tagName ?? "1"
                    tagName = tagName.replacingOccurrences(of: " ", with: "%20")
                    self?.menuViewModel.loadTagItems(tagName: tagName)
                }
                self?.menuTableView.reloadData()
            }, onError: { [weak self] error in
                self?.view.makeToast(error.localizedDescription)
        }).disposed(by: disposeBag)
        
        loadNewPage()
    }

}

extension MenuVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.identifier, for: indexPath) as! MenuCell
        cell.selectionStyle = .none
        cell.tags = tags
        cell.items = items
        cell.delegate = self
        cell.populateData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, percentage: 15)
        for _ in items {
            height = height + UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, percentage: 10)
        }
        return height
    }
}

extension MenuVC: MenuCellDelegate {
    func updateItems(tagName: String) {
        let tagNameWithoutSpace = tagName.replacingOccurrences(of: " ", with: "%20")
        self.menuViewModel.loadTagItems(tagName: tagNameWithoutSpace)
    }
    
    func loadNewPage() {
        menuViewModel.loadTagsPage(page: "\(nextPage)")
        nextPage = nextPage + 1
    }
}
