//
//  UsersTableViewCell.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 21/10/1443 AH.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    //MARK: - IB Outlets
    
    @IBOutlet weak var avatarImageViewOutlet: UIImageView!
    
    @IBOutlet weak var usernameLabelOutlet: UILabel!
    
    @IBOutlet weak var statusLabelOutlet: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(user: User) {
        usernameLabelOutlet.text = user.username
        statusLabelOutlet.text = user.status
        if user.avatarLink != "" {
            FileStorage.downloadImage(imageUrl: user.avatarLink) { avatarImage in
                self.avatarImageViewOutlet.image = avatarImage?.circleMasked
            }
        } else {
            self.avatarImageViewOutlet.image = UIImage(named: "avatar")
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
