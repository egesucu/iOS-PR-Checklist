//
//  ListView.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 27.08.2025.
//

import SwiftUI

struct ListView: View {
    @State var imaginaryData: [Item] = []
    @State var searchTerm = "Holly"
    @State private var showDailyMeaning = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Items")
                        .font(.title)
                        .padding(.leading, 15)
                        .accessibilityIdentifier("items_title")
                    ForEach(imaginaryData) { data in
                        LyricView(content: data.content, position: data.position)
                            .accessibilityElement(children: .contain)
                            .accessibilityIdentifier("item_row_\(data.id)")
                    }
                    Button("Meaning of the Day") {
                        showDailyMeaning.toggle()
                    }
                    .accessibilityIdentifier("daily_button")
                    .buttonStyle(.borderedProminent)
                }
                .accessibilityElement(children: .contain)
                .accessibilityIdentifier("items_list")
            }
            .accessibilityIdentifier("items_scroll")
            .navigationTitle("Item List")
            .sheet(isPresented: $showDailyMeaning) {
                DailyMeaningView(searchTerm: searchTerm)
            }
        }
        
    }
}

#Preview {
    let items = Item.demoItems
    
    return NavigationStack {
        ListView(imaginaryData: items)
            .navigationTitle("Item List")
    }
}
