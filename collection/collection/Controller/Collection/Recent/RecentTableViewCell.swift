//
//  RecentTableViewCell.swift
//  collection
//
//  Created by Larissa Lanes on 29/09/23.
//

import UIKit

class RecentTableViewCell: UITableViewCell {

    static let identifier = "RecentTableViewCell"
    
    func configure(with recents: [ModelRecents]){
        self.recents = recents
        collectionViewRecent.reloadData()
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var collectionViewRecent: UICollectionView!
    @IBOutlet var backgroundCollection: UIView!
    
    var recents = [ModelRecents]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.textColor = .text
        self.backgroundCollection.backgroundColor = .backgroundPage
        self.collectionViewRecent.backgroundColor = .backgroundPage
        
        collectionViewRecent.register(UINib(nibName: "MyRecentCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyRecentCollectionViewCell")
        collectionViewRecent.delegate = self
        collectionViewRecent.dataSource = self
    }
}

extension RecentTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyRecentCollectionViewCell", for: indexPath) as! MyRecentCollectionViewCell
        
        cell.configure(with: recents[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 400, height: 400)
    }
}
