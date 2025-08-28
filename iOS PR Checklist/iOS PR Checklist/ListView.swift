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
        ScrollView {
            VStack(alignment: .leading) {
                Text("Items")
                    .font(.title)
                    .padding(.leading, 15)
                ForEach(imaginaryData) { data in
                    LyricView(content: data.content, position: data.position)
                }
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
