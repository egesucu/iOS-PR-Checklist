//
//  Meaning.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 30.08.2025.
//

import Foundation

struct MeaningModel: Codable {
    let word: String
    let meanings: [Meaning]
    let sourceURLS: [String]
    
    enum CodingKeys: String, CodingKey {
        case word
        case meanings = "meanings"
        case sourceURLS = "sourceUrls"
    }
}

struct Meaning: Codable, Equatable, Hashable {
    static func == (lhs: Meaning, rhs: Meaning) -> Bool {
        lhs.definitions == rhs.definitions
    }
    
    let definitions: [Definition]
}

struct Definition: Codable, Equatable, Hashable {
    let content: String
    let synonyms: [String]
    let example: String?
    
    enum CodingKeys: String, CodingKey {
        case content = "definition"
        case synonyms
        case example
    }
}

struct MeaningError: Codable {
    let title: String
    let message: String
    let resolution: String
}
