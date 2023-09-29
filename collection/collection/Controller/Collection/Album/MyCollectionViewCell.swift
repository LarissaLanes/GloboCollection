//
//  MyCollectionViewCell.swift
//  collection
//
//  Created by Larissa Lanes on 29/09/23.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewPorcent: UIView!
    @IBOutlet var myImageView: UIImageView!
    
    static let identifier = "MyCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.viewPorcent.backgroundColor = .red
    }
    
    public func configure(with model: Model) {
        self.myImageView.image = UIImage(named: model.imageName)
    }

}
