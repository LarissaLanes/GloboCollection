//  CollectionItemCell.swift
//  collectionProject
//
//  Created by Larissa Lanes on 28/09/23.
//

import UIKit

class GalerysTableViewCell: UITableViewCell {

    static let identifier = "GalerysTableViewCell"

    @IBOutlet var collectionView: UICollectionView!

    var collections: [Collection] = []

    func configure(with collections: [Collection]) {
        self.collections = collections
        collectionView.reloadData()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.backgroundColor = .backgroundPage

        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .vertical
            let numberOfItemsPerRow: CGFloat = 3
            let spacingBetweenCells: CGFloat = 0

            let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells
            let itemWidth = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow

            flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        }

        collectionView.register(UINib(nibName: "CollectionItemCell", bundle: nil), forCellWithReuseIdentifier: "CollectionItemCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension GalerysTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionItemCell", for: indexPath) as! CollectionItemCell

        let collection = collections[indexPath.item]
        cell.configure(with: collection)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCollection = collections[indexPath.item]

        let infoViewController = InfoViewController()
        infoViewController.collectionData = selectedCollection

        if let navigationController = findNavigationController() {
            navigationController.pushViewController(infoViewController, animated: true)
        }
    }

    func findNavigationController() -> UINavigationController? {
        var responder: UIResponder? = self
        while responder != nil {
            if let navController = responder as? UINavigationController {
                return navController
            }
            responder = responder?.next
        }
        return nil
    }
}
