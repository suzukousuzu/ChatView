//
//  User.swift
//  ChatView
//
//  Created by 鈴木航太 on 2024/03/05.
//

import SwiftUI

struct User: Decodable {
    let id: String
    let name: String
    let image: String
    
    var isCurrentUser: Bool {
        self.id == User.currentUser.id
    }
    
    static var currentUser: User {
        User(id: "1", name: "カーキ", image: "user01")
    }
}

