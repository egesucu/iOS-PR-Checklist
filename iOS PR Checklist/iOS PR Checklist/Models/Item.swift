//
//  Item.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 27.08.2025.
//

import Foundation

struct Item: Identifiable {
    let content: String
    let position: LyricPosition
    
    var id: String {
        content
    }
}

extension Item {
    // Check out https://www.youtube.com/watch?v=bGNT5Uh-WKw
    static let demoItems: [Self] = [
        .init(content: "Hey ho! Let's go", position: .left),
        .init(content: "Folklore și Rock'n'roll", position: .right),
        .init(content: "Pleacă trenul! Unde esti?", position: .left),
        .init(content: "Chișinău – București", position: .right)
    ]
}
