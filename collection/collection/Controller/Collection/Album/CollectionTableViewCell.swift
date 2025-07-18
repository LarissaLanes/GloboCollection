//
//  CollectionTableViewCell.swift
//  collection
//
//  Created by Larissa Lanes on 29/09/23.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    static let identifier = "CollectionTableViewCell"
    
    func configure(with models: [Model]) {
        self.models = models
        collectionView.reloadData()
    }
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var backgroundCollection: UIView!
    
    var models = [Model]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.titleLabel.textColor = .text
        collectionView.backgroundColor = .backgroundPage
        self.backgroundCollection.backgroundColor = .backgroundPage
        self.collectionView.backgroundColor = .backgroundPage

        collectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCellTap(_:)))
        collectionView.addGestureRecognizer(tapGesture)
    }

//     Método chamado quando um item da coleção é tocado
    @objc func handleCellTap(_ sender: UITapGestureRecognizer) {
        if let tappedIndexPath = collectionView.indexPathForItem(at: sender.location(in: collectionView)) {
            let tappedCollection = models[tappedIndexPath.row].figurinhas

            let detailsVC = DetailsTableViewController()

            detailsVC.collections = tappedCollection

            if let navigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {

                navigationController.pushViewController(detailsVC, animated: true)
            } else {

                let navigationController = UINavigationController(rootViewController: detailsVC)

                if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                    viewController.present(navigationController, animated: true, completion: nil)
                }
            }
        }
    }
}

extension CollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        
        cell.configure(with: models[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 500)
    }
}
