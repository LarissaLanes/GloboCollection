//
//  CollectionItemCell.swift
//  collectionProject
//
//  Created by Larissa Lanes on 28/09/23.
//

import UIKit

class CollectionItemCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var raridade: UILabel!
    @IBOutlet weak var titleImage: UILabel!
    
    static let identifier = "CollectionItemCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with collection: Collection) {

        let stickerID = UserDefaults.standard.integer(forKey: "stickerResgatado\(collection.id)")

        if stickerID == collection.id {
            print("id: \(stickerID)")
            image.image = UIImage(named: collection.imagemDesbloqueada)
            titleImage.text = collection.nome
            
            if collection.raridade == true{
                raridade.text = "RARA"
                raridade.textColor = .red
            }else{
                raridade.text = "NORMAL"
                raridade.textColor = .white
            }

        } else {
            image.image = UIImage(named: collection.imagemBloqueada)
            titleImage.text = collection.nome
            
            if collection.raridade == true{
                raridade.text = "RARA"
                raridade.textColor = .red
            }else{
                raridade.text = "NORMAL"
                raridade.textColor = .white
            }
        }
    }
}
