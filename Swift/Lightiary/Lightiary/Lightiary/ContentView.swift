//
//  ContentView.swift
//  Lightiary
//
//  Created by Parsa Farjam on 30/01/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var entries: [Entry]

    var body: some View {
        VStack {
            Text("Welcome to").font(.system(size:24, weight: .light, design: .serif)).multilineTextAlignment(.leading)
            Text("Lightiary").font(.system(size:48, weight: .black, design: .serif)).multilineTextAlignment(.leading)
        } .padding(EdgeInsets(top: 50, leading: 0, bottom: 30, trailing: 0))
        
        NavigationSplitView {
            List {
                ForEach(entries) { entry in
                    NavigationLink {
                        Text("New diary entry at \(entry.date_created, format: Date.FormatStyle(date: .numeric, time: .standard))").font(.system(.body, design: .serif))
                    } label: {
                        Text(entry.date_created, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addEntry) {
                        Label("Add Entry", systemImage: "plus")
                    }
                }
            }.font(.system(.body, design: .serif))

        } detail: {
            Text("Select an entry")
        }
    }

    private func addEntry() {
        withAnimation {
            let newEntry = Entry(current_date: Date())
            modelContext.insert(newEntry)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(entries[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Entry.self, inMemory: true)
}
