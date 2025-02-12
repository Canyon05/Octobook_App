//
//  ContentView.swift
//  Octobook
//
//  Created by Elias Zeh on 12.02.25.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        BookList()
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
