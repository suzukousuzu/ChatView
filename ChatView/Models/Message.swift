//
//  Message.swift
//  ChatView
//
//  Created by 鈴木航太 on 2024/03/05.
//

import SwiftUI

struct Message: Decodable, Identifiable, Equatable {
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: String
    let text: String
    let user: User
    let date: String
    let readed: Bool
}
