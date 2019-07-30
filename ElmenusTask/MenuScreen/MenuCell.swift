//
//  MenuCell.swift
//  ElmenusTask
//
//  Created by Hesham Donia on 7/29/19.
//  Copyright © 2019 Hesham Donia. All rights reserved.
//

import UIKit

public protocol MenuCellDelegate: class {
    func loadNewPage()
    func updateItems(tagName: String)
    func navigateToItemDetails(item: Item)
}

class MenuCell: UITableViewCell {

    public static let identifier = "MenuCell"
    
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    @IBOutlet weak var itemsTableView: UITableView!
    
    public var tags: [Tag]!
    public var items: [Item]!
    public var delegate: MenuCellDelegate!
    
    public func populateData() {
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        itemsTableView.reloadData()
        
        if let layout = tagsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        tagsCollectionView.dataSource = self
        tagsCollectionView.delegate = self
        tagsCollectionView.reloadData()
    }
    
}

extension MenuCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemsTableViewCell.identifier, for: indexPath) as! ItemsTableViewCell
        cell.selectionStyle = .none
        cell.item = items.get(indexPath.row)
        cell.populateData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, percentage: 10)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // go to item details
        print("Go to item details with shared element transition")
        delegate.navigateToItemDetails(item: items.get(indexPath.row)!)
    }
}

extension MenuCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagsCollectionViewCell.identifier, for: indexPath) as! TagsCollectionViewCell
        cell.menuTag = tags.get(indexPath.row)
        cell.populateData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // update table view
        self.delegate.updateItems(tagName: self.tags.get(indexPath.row)?.tagName ?? "1")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let length = UiHelpers.getLengthAccordingTo(relation: .SCREEN_HEIGHT, percentage: 15)
        return CGSize(width: length, height: length)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if ((self.tagsCollectionView.contentOffset.x + self.tagsCollectionView.frame.size.width) + 8 >= self.tagsCollectionView.contentSize.width)  {
            self.delegate.loadNewPage()
        }
    }
    
    
}
