//
//  ListView.swift
//  ChatView
//
//  Created by 鈴木航太 on 2024/03/07.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var vm: ChatViewModel = ChatViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: - Header
                header
                
                // MARK: - List
                list
            }
            .padding(.horizontal)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}

extension ListView {
    private var header: some View {
        HStack {
            Text("トーク")
                .font(.title2.bold())
            
            Spacer()
            
            HStack(spacing: 16) {
                Image(systemName: "text.badge.checkmark")
                
                Image(systemName: "square")
                Image(systemName: "ellipsis.bubble")
                
            }
            .font(.title2)
        }
    }
    
    private var list: some View {
        ScrollView {
            VStack {
                ForEach(vm.chatData) { chat in
                    NavigationLink {
                        ChatView(chat: chat)
                            .environmentObject(vm)
                            .toolbar(.hidden)
                    } label: {
                        listRow(chat: chat)
                    }
                }
            }
        }
    }
    
    private func listRow(chat: Chat) -> some View {
        //private var listRow: some View {
        HStack {
            
            let images = vm.getImages(messages: chat.messages)
            
            HStack (spacing: -28) {
                ForEach(images, id: \.self) { image in
                    Image(image)
                        .resizable()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                        .background(
                        Circle()
                            .foregroundColor(Color(uiColor: .systemBackground))
                            .frame(width: 54, height: 54)
                        )
                }
            }
            
            
            VStack(alignment: .leading) {
                Text(vm.getTitle(messages: chat.messages))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                Text(chat.recentMessageText)
                    .font(.footnote)
                    .lineLimit(1)
                    .foregroundColor(Color(uiColor: .secondaryLabel))
            }
            
            Spacer()
            
            Text(chat.recentMessagesDateString)
                .font(.caption)
                .foregroundColor(Color(uiColor: .secondaryLabel))
        }
    }
}
