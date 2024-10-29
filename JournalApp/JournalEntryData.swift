//
//  JournalEntryData.swift
//  JournalApp
//
//  Created by Noura Alrowais on 24/04/1446 AH.
//

import Foundation
import SwiftData
@Model
final class JournalEntry{
    let id: UUID // Unique identifier for each entry
    var date: Date
    var title: String
    var content: String
    var isBookmarked: Bool
    
    init(title: String = "", date: Date = .now, content: String = "", isBookmarked: Bool = false) {
        self.id = UUID() // Generate a unique ID for each new entry
        self.date = date
        self.title = title
        self.content = content
        self.isBookmarked = isBookmarked
    }
}
