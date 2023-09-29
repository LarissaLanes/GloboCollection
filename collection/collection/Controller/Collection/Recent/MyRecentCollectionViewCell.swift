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
        // Initialization code
    }
    
    public func configure(with recents: ModelRecents) {
        self.myImageView.image = UIImage(named: recents.image)
        self.title.text = recents.title
        self.subTitle.text = recents.legend
    }

}
