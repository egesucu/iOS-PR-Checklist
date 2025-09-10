//
//  iOS_PR_ChecklistTests.swift
//  iOS PR ChecklistTests
//
//  Created by Sucu, Ege on 1.09.2025.
//

import Testing
@testable import iOS_PR_Checklist

struct iOS_PR_ChecklistTests {
    
    let dictionaryManager: MockDictionaryManager
    let backgroundTaskManager: MockBackgroundTaskManager
    
    init() {
        self.dictionaryManager = MockDictionaryManager()
        self.backgroundTaskManager = MockBackgroundTaskManager()
    }
    
    @Test
    func `Test a successful fetch`() async throws {
        dictionaryManager.shouldThrowError = false
        dictionaryManager.mockMeanings = [.init(
            word: "Morning",
            meanings: [.init(
                definitions: [.init(
                    content: "A time of day between night and afternoon.",
                    synonyms: [],
                    example: "Good Morning"
                )]
            )],
            sourceURLS: []
        )]
        
        let meanings = try await dictionaryManager.fetchWord(searchTerm: "Morning")
        
        #expect(!meanings.isEmpty)
        #expect(dictionaryManager.errorToThrow == nil)
        #expect(meanings.first?.word == "Morning")
        #expect(meanings.first?.meanings.first?.definitions.first?.example == "Good Morning")
    }
    
    @Test
    func `Test an invalid URL failure`() async throws {
        dictionaryManager.shouldThrowError = true
        dictionaryManager.errorToThrow = .invalidURL
       
        await #expect(throws: DictionaryError.invalidURL.self) {
            _ = try await dictionaryManager.fetchWord(searchTerm: "Morning")
        }
        #expect(dictionaryManager.errorToThrow == .invalidURL)
    }
    
    @Test
    func `Test not founded error`() async throws {
        dictionaryManager.shouldThrowError = true
        dictionaryManager.errorToThrow = .wordNotFound(title: "The word you're looking has not been found", resolution: "Try a different word")
        
        await #expect(throws: DictionaryError.wordNotFound(title: "The word you're looking has not been found", resolution: "Try a different word").self) {
            _ = try await dictionaryManager.fetchWord(searchTerm: "Morning")
        }
    }
    
    @Test
    func `Test default failuıre on mock`() async throws {
        dictionaryManager.shouldThrowError = true
        dictionaryManager.errorToThrow = nil
        
        await #expect(throws: DictionaryError.invalidURL.self) {
            _ = try await dictionaryManager.fetchWord(searchTerm: "Morning")
        }
    }
    
    @Test
    func `Test Mock Background Data Fetch`() async throws {
        let task = backgroundTaskManager.startFakeBackgroundTaskConcurrency()
        await task.value
        #expect(backgroundTaskManager.resultConcurrency == "✅ Concurrency: finished background work")
    }
}
