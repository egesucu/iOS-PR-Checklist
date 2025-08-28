//
//  LyricView.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 28.08.2025.
//

import SwiftUI

struct LyricView: View {
    
    let content: String
    let position: LyricPosition
    
    var body: some View {
        HStack {
            if position == .right {
                Spacer()
            }
            Text(content)
                .padding()
                .background(
                    Capsule()
                        .fill(Color.gray.opacity(0.2))
                )
            if position == .left {
                Spacer()
            }
        }
        .padding()
    }
}

#Preview {
    Group {
        LyricView(content: Item.demoItems[0].content, position: .left)
        LyricView(content: Item.demoItems[1].content, position: .right)
    }
}
