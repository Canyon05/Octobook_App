//
//  ReadButton.swift
//  Octobook
//
//  Created by Elias Zeh on 13.02.25.
//

import SwiftUI

struct ReadButton: View {
    @Binding var isRead: Bool
    var toggleRead: () -> Void  // Callback to update data

    var body: some View {
        Button {
            isRead.toggle()
            toggleRead()  // Notify BookData to save changes
        } label: {
            Label("Toggle read", systemImage: isRead ? "book.closed.fill" : "book.closed")
                .labelStyle(.iconOnly)
                .foregroundStyle(isRead ? .blue : .gray)
        }
    }
}

#Preview {
    ReadButton(isRead: .constant(true), toggleRead: {})
}
