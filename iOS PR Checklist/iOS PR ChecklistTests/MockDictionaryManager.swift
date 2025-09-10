//
//  MockDictionaryManager.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 1.09.2025.
//

import Foundation
@testable import iOS_PR_Checklist

final class MockDictionaryManager: DictionaryManager {
    var shouldThrowError: Bool = false
    var errorToThrow: DictionaryError? = nil
    var mockMeanings: [MeaningModel] = []

    @MainActor
    func fetchWord(searchTerm: String) async throws(DictionaryError) -> [MeaningModel] {
        if shouldThrowError {
            throw errorToThrow ?? .invalidURL
        } else {
            return mockMeanings
        }
    }
}
