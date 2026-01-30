//
//  entry.swift
//  Lightiary
//
//  Created by Parsa Farjam on 30/01/2026.
//

import Foundation
import SwiftData

@Model
final class Entry {
    
    var id = UUID()
    var title: String
    var date_created: Date
    var date_modified: Date
    var content: String
    
    
    init(current_date: Date) {
        let df = DateFormatter();
        self.title = "New Entry at " + df.string(from: current_date)
        self.date_created = current_date
        self.date_modified = current_date
        self.content = ""
    }
}
