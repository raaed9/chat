//
//  MessageDisplayDelegate.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 26/10/1443 AH.
//

import Foundation
import MessageKit

extension MSGViewController: MessagesDisplayDelegate {
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        
        return .label
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        
        let bubbleColorOutgoing = UIColor(named: "colorOutgoingBubble")
        let bubbleColorIncoming = UIColor(named: "colorIncomingBubble")
        
        return isFromCurrentSender(message: message) ? bubbleColorOutgoing as! UIColor : bubbleColorIncoming as! UIColor

    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let tail: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        
        return .bubbleTail(tail, .curved)
    }
    
}
