//
//  ChatService.swift
//  onTop
//
//  Created by Alexandru Vrincean on 04/07/2019.
//  Copyright © 2019 Alexandru Vrincean. All rights reserved.
//

import Foundation

class ChatService {
    private var chats: [Chat] = [Chat(announcementId: 32, organisationName: "Banca Transilvania", announcementTitle: "Apple Pay. Aici. Acum.")]
    private var conv: [Chat: [Message]] = [Chat(announcementId: 32, organisationName: "Banca Transilvania", announcementTitle: "Apple Pay. Aici. Acum."):[Message(text: "Bună ziua, de când se vor aplica schimbările ?", isUser: true), Message(text: "Bună ziua, începănd cu data de 26.06.2019 se va putea benefica de Apple Pay.", isUser: false), Message(text: "Mulțumesc de informație, o zi bună", isUser: true), Message(text: "Mulțumim că a-ți aplelat la noi !", isUser: false)]]
    
    func getChats() -> [Chat] {
        return chats.reversed()
    }
    
    func isChat(for announcementId: Int) -> Bool {
        return chats.first { $0.announcementId == announcementId} == nil
    }
    
    func getConversation(announcementId: Int) -> [Message] {
        if let chat = chats.first(where: { $0.announcementId == announcementId}) {
            return conv[chat] ?? []
        }
        
        return []
    }
    
    func createChat(announcementId: Int, organisationName: String, announcementTitle: String) {
        let chat = Chat(announcementId: announcementId, organisationName: organisationName, announcementTitle: announcementTitle)
        chats.append(chat)
    }
    
    func addMessage(announcementId: Int, message: Message) {
        if let chat = chats.first(where: { $0.announcementId == announcementId}) {
            if var messages = conv[chat] {
                messages.append(message)
                conv[chat] = messages
            } else {
                conv[chat] = [message]
            }
        }
    }
}
