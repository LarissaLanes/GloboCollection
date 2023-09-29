//
//  CollectionItemCell.swift
//  collectionProject
//
//  Created by Larissa Lanes on 28/09/23.
//

import UIKit

class CollectionItemCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleImage: UILabel!
    
    static let identifier = "CollectionItemCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with collection: Collection) {
           // Configure a célula com os dados da coleção
           image.image = UIImage(named: collection.imagem)
        titleImage.text = collection.nome

           // Configure outros elementos conforme necessário
       }

}
