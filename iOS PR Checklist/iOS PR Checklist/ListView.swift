//
//  ListView.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 27.08.2025.
//

import SwiftUI

struct ListView: View {
    @State var imaginaryData: [Item] = []
    
    var body: some View {
        List {
            Section {
                ForEach(imaginaryData) { data in
                    Text(data.content)
                }
            } header: {
                Text("Items")
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
