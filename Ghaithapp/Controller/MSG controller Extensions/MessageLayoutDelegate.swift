//
//  MessageLayoutDelegate.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 26/10/1443 AH.
//

import Foundation
import MessageKit

extension MSGViewController: MessagesLayoutDelegate {
    
    //MARK: -  Cell top label height
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        
        if indexPath.section % 3 == 0 {
            //TODO:- set different size for pull to load more message
            
            if ((indexPath.section == 0) && (allLocalMessages.count > dispayingMessagesCount)) {
                return 40
            }
            
        }
        
        return 10
    }
    
    //MARK: - cell bottom label height
    
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        
        return isFromCurrentSender(message: message) ? 17 : 0
    }
    
    
    //MARK: - message bottom label height
    
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        
        return indexPath.section != mkMessages.count - 1 ? 10 : 0
    }
    
    //MARK: - avatar initials
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        
        avatarView.set(avatar: Avatar(initials: mkMessages[indexPath.section].senderInitals))
    }
}
