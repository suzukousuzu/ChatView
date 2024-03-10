//
//  Chat.swift
//  ChatView
//
//  Created by 鈴木航太 on 2024/03/05.
//

import SwiftUI

struct Chat: Decodable, Identifiable {
    let id: String
    var messages: [Message]
    
    var recentMessageText: String {
        guard let recentMessage = self.messages.last else {
            return ""
        }
        
        return recentMessage.text
    }
    
    var recentMessagesDateString: String {
        guard let recentMessage = self.messages.last else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = formatter.date(from: recentMessage.date) else {
            return ""
        }
        formatter.dateFormat = "MM/dd"
        return formatter.string(from: date)
    }
}
