//
//  RankingTableViewCell.swift
//  collection
//
//  Created by Larissa Lanes on 09/10/23.
//

import UIKit

class RankingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundRanking: UIView!
    @IBOutlet weak var numberPosition: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var valueOfPorcent: UILabel!
    @IBOutlet weak var itemSavedProfile: UIImageView!
    
    static let identifier = "RankingTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with configure: User) {
        self.profilePicture.image = UIImage(named: configure.image)
        self.mail.text = configure.email
        self.name.text = configure.name
        self.valueOfPorcent.text = "\(configure.porcent)"
    }

    
}
