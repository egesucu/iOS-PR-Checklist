//
//  Item.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 27.08.2025.
//

import Foundation

struct Item: Identifiable {
    var content: String
    
    var id: String {
        content
    }
}

extension Item {
    // Check out https://www.youtube.com/watch?v=bGNT5Uh-WKw
    static let demoItems: [Self] = [
        .init(content: "Hey ho! Let's go"),
        .init(content: "Folklore și Rock'n'roll"),
        .init(content: "Pleacă trenul! Unde esti?"),
        .init(content: "Chișinău – București")
    ]
}
