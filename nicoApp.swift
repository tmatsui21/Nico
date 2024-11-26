//
//  nicoApp.swift
//  nico
//
//  Created by Takashi Matsui on 2024/11/10.
//

import SwiftUI
import SwiftData

@main
struct nicoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Talk.self)
        }
    }
}
