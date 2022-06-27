//
//  ChatTableViewCell.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 21/10/1443 AH.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    //MARK: - IB Outlets
    
    
    @IBOutlet weak var avatarImageOutlet: UIImageView!
    @IBOutlet weak var usernameLabelOutlet: UILabel!
    @IBOutlet weak var lastMessageLabelOutlet: UILabel!
    @IBOutlet weak var dateLabelOutlet: UILabel!
    @IBOutlet weak var unreadCounterLabelOutlet: UILabel!
    @IBOutlet weak var unreadCounterViewOutlet: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        unreadCounterViewOutlet.layer.cornerRadius = unreadCounterViewOutlet.frame.width / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure (chatRoom: ChatRoom) {
        usernameLabelOutlet.text = chatRoom.receiverName
        usernameLabelOutlet.minimumScaleFactor = 0.9
        
        lastMessageLabelOutlet.text = chatRoom.lastMessage
        lastMessageLabelOutlet.numberOfLines = 2
        lastMessageLabelOutlet.minimumScaleFactor = 0.9
        
        if chatRoom.unreadCounter != 0 {
            self.unreadCounterLabelOutlet.text = "\(chatRoom.unreadCounter)"
            self.unreadCounterViewOutlet.isHidden = false
        } else {
            self.unreadCounterViewOutlet.isHidden = true
        }
        
        if chatRoom.avatarLink != "" {
            
            FileStorage.downloadImage(imageUrl: chatRoom.avatarLink) { avatarImage in
                self.avatarImageOutlet.image = avatarImage?.circleMasked
                
            }
        } else {
            self.avatarImageOutlet.image = UIImage(named: "avatar")
        }
        
        dateLabelOutlet.text = timeElapsed(chatRoom.date ?? Date())
    

}

}
