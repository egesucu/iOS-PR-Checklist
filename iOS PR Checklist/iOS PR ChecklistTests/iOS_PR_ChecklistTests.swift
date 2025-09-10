//
//  iOS_PR_ChecklistTests.swift
//  iOS PR ChecklistTests
//
//  Created by Sucu, Ege on 1.09.2025.
//

import Testing
@testable import iOS_PR_Checklist

struct iOS_PR_ChecklistTests {
    
    let manager: MockDictionaryManager
    
    init() {
        self.manager = MockDictionaryManager()
    }
    
    @Test("Test a successful fetch")
    func testSuccessfullFetch() async throws {
        manager.shouldThrowError = false
        manager.mockMeanings = [.init(
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
        
        let meanings = try await manager.fetchWord(searchTerm: "Morning")
        
        #expect(!meanings.isEmpty)
        #expect(manager.errorToThrow == nil)
        #expect(meanings.first?.word == "Morning")
        #expect(meanings.first?.meanings.first?.definitions.first?.example == "Good Morning")
    }
    
    @Test("Test an invalid URL failure")
    func testInvalidURLFailure() async throws {
        manager.shouldThrowError = true
        manager.errorToThrow = .invalidURL
       
        await #expect(throws: DictionaryError.invalidURL.self) {
            _ = try await manager.fetchWord(searchTerm: "Morning")
        }
        #expect(manager.errorToThrow == .invalidURL)
    }
    
    @Test("Test not founded error")
    func testWordNotFoundedFailure() async throws {
        manager.shouldThrowError = true
        manager.errorToThrow = .wordNotFound(title: "The word you're looking has not been found", resolution: "Try a different word")
        
        await #expect(throws: DictionaryError.wordNotFound(title: "The word you're looking has not been found", resolution: "Try a different word").self) {
            _ = try await manager.fetchWord(searchTerm: "Morning")
        }
    }
    
    @Test("Test default failuıre on mock")
    func testDefaultFailureOnMock() async throws {
        manager.shouldThrowError = true
        manager.errorToThrow = nil
        
        await #expect(throws: DictionaryError.invalidURL.self) {
            _ = try await manager.fetchWord(searchTerm: "Morning")
        }
    }
}
