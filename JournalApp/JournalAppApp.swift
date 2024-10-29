//
//  JournalAppApp.swift
//  JournalApp
//
//  Created by Noura Alrowais on 18/04/1446 AH.
//

import SwiftUI
import SwiftData
@main
struct JournalAppApp: App {
    
    var body: some Scene {
        WindowGroup {
           ContentView().modelContainer(for: JournalEntry.self)
        }
    }
}
