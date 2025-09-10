//
//  DictionaryError.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 30.08.2025.
//

import Foundation

enum DictionaryError: Error, Equatable {
    case invalidURL
    case wordNotFound(title: String, resolution: String)
    case decodingFailed(reason: String)
    case networkIssue(details: String)
}
