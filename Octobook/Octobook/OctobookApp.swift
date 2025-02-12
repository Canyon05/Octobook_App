//
//  OctobookApp.swift
//  Octobook
//
//  Created by Elias Zeh on 12.02.25.
//

import SwiftUI
import SwiftData

@main
struct OctobookApp: App {
    @State private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
