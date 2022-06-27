//
//  InputBarAccessoryViewDelegate.swift
//  Ghaithapp
//
//  Created by Raed Alharbi on 26/10/1443 AH.
//

import Foundation
import InputBarAccessoryView
import MessageKit

extension MSGViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {
        print("Typing", text)
        
        updateMicButtonStatus(show: text == "")
        
        if text != "" {
            startTypingIndicator()
        }
        
    }
    
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {

        send(text: text, photo: nil, video: nil, audio: nil, location: nil)
        messageInputBar.inputTextView.text = ""
        messageInputBar.invalidatePlugins()
    }
}
