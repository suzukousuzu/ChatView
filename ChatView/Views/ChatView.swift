//
//  ChatView.swift
//  ChatView
//
//  Created by 鈴木航太 on 2024/03/04.
//

import SwiftUI

struct ChatView: View {
    var chat: Chat
    
    @State private var text: String = ""
    @FocusState private var textFieldFocued: Bool
    //@ObservedObject var vm: ChatViewModel = ChatViewModel()
    @EnvironmentObject var vm: ChatViewModel
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            // MARK: - MessageArea
            messagerea
            // MARK: - NavigationArea
                .overlay(
                    navigationArea
                    ,alignment: .top
                )
            // MARK: - InputArea
            inputArea
        }
    }
}

//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView()
//    }
//}

extension ChatView {
    private var messagerea: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(chat.messages) { message in
                        MessageRow(message: message)
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top, 72)
                
            }
            .background(Color("Background"))
            .onTapGesture {
                textFieldFocued = false
            }
            .onAppear(perform: {
                scrollToLast(proxy:
                                proxy, messages: chat.messages)
                
            }
            )
            .onChange(of: chat.messages) {newValue in
                scrollToLast(proxy: proxy, smooth: true, messages: newValue)
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                scrollToLast(proxy:
                                proxy, messages: chat.messages)
                
            }
            
            
        }
    }
    
    private var inputArea: some View {
        HStack {
            HStack(spacing: 8) {
                Image(systemName: "plus")
                Image(systemName: "camera")
                Image(systemName: "photo")
            }
            .font(.title2)
            
            TextField("Aa", text: $text)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
                .clipShape(Capsule())
                .overlay(
                    Image(systemName: "face.smiling")
                        .font(.title2)
                        .padding(.trailing)
                        .foregroundColor(.gray)
                    
                    , alignment: .trailing
                )
                .onSubmit {
                    sendMessage()
                }
                .focused($textFieldFocued)
            
            Image(systemName: "mic")
                .font(.title2)
            
        }
        .background(Color(uiColor: .systemBackground))
        .padding()
    }
    
    private var navigationArea: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            
            Text("Title")
                .font(.title2.bold())
            Spacer()
            
            HStack(spacing: 16) {
                Image(systemName: "text.magnifyingglass")
                Image(systemName: "phone")
                Image(systemName: "line.3.horizontal")
            }
            .font(.title2)
            
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color("Background").opacity(0.9))
    }
    
    private func sendMessage() {
        if (text.isEmpty) {
            return
        }
        vm.addMessage(chatId: chat.id , text: text)
        text = ""
    }
    
    private func scrollToLast(proxy: ScrollViewProxy, smooth: Bool = false , messages: [Message]) {
        

        if let lastMessage = messages.last {
            if (smooth) {
                withAnimation() {
                    proxy.scrollTo(lastMessage.id, anchor: .bottom)
                }
            } else {
                proxy.scrollTo(lastMessage.id, anchor: .bottom)
            }
            
        }
    }
}
