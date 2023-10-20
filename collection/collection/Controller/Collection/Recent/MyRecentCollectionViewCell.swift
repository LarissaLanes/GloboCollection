//
//  MyRecentCollectionViewCell.swift
//  collection
//
//  Created by Larissa Lanes on 29/09/23.
//

import UIKit

class MyRecentCollectionViewCell: UICollectionViewCell {

    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var subTitle: UILabel!
    
    static let identifier = "MyCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with recents: ModelRecents) {

        let stickerID = UserDefaults.standard.integer(forKey: "stickerResgatado\(recents.id)")

        if stickerID == recents.id {
            myImageView.image = UIImage(named: recents.imagemDesbloqueada)
//            title.text = recents.nome
//            subTitle.text = recents.album
            
        } else {
            myImageView.image = UIImage(named: "")
        }
    }
}



