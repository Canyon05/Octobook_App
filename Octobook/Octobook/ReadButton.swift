//
//  ReadButton.swift
//  Octobook
//
//  Created by Elias Zeh on 13.02.25.
//

import SwiftUI

struct ReadButton: View {
    @Binding var isSet: Bool

    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            Label("Toggle read", systemImage: isSet ? "book.closed.fill" : "book.closed")
                .labelStyle(.iconOnly)
                .foregroundStyle(isSet ? .blue : .gray)
        }
    }
}

#Preview {
    ReadButton(isSet: .constant(true))
}
