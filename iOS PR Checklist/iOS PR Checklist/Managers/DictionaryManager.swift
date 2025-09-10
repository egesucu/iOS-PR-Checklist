//
//  DictionaryManager.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 30.08.2025.
//

import Foundation

/// Protocol defining the contract for fetching word meanings from a dictionary API.
protocol DictionaryManager {
    /// Fetches meanings for a given search term asynchronously.
    /// - Parameter searchTerm: The word to search for in the dictionary.
    /// - Throws: DictionaryError if the fetch fails or the word is not found.
    /// - Returns: An array of MeaningModel representing the meanings of the word.
    func fetchWord(searchTerm: String) async throws(DictionaryError) -> [MeaningModel]
}

/// Implementation of the DictionaryManager protocol.
/// This class is designed as a singleton and handles interaction with the dictionary API.
final class DictionaryManagerImplementation: DictionaryManager {
    static let shared = DictionaryManagerImplementation()
    
    private let requestURL = "https://api.dictionaryapi.dev/api/v2/entries/en/"
    
    /// Fetches the meanings of a word from the dictionary API.
    /// - Parameter searchTerm: The word to look up.
    /// - Throws: DictionaryError for various failure cases including invalid URL, network issues, decoding failures, or word not found.
    /// - Returns: An array of MeaningModel containing the definitions of the word.
    @MainActor
    func fetchWord(searchTerm: String) async throws(DictionaryError) -> [MeaningModel] {
        guard let url = URL(string: requestURL) else {
            print("URL is invalid.")
            throw DictionaryError.invalidURL
        }
        
        do {
            let request = url.appending(path: searchTerm)
            print("URL is: \(request.absoluteString)")
            let (data, response) = try await URLSession.shared.data(from: request)
            
            if let response = response as? HTTPURLResponse,
               response.statusCode == 404 {
                /// On the error, the API throws a different model for us to handle.
                let errorModel = try JSONDecoder().decode(MeaningError.self, from: data)
                throw DictionaryError.wordNotFound(title: errorModel.title, resolution: errorModel.resolution)
            } else {
                /// Obtain the result model we wish to get for
                let model = try JSONDecoder().decode([MeaningModel].self, from: data)
                return model
            }
            
        } catch let error as URLError {
            switch error.code {
            case .networkConnectionLost, .notConnectedToInternet:
                throw DictionaryError.networkIssue(details: error.localizedDescription)
            default:
                throw DictionaryError.invalidURL
            }
        } catch let error as DecodingError {
            switch error {
            case .typeMismatch(let any, let context):
                print("Type is mismatched for \(any) in the \(context.debugDescription)")
                throw DictionaryError.decodingFailed(reason: error.localizedDescription)
            case .valueNotFound(let any, let context):
                print("Value is not found for \(any) in the \(context.debugDescription)")
                throw DictionaryError.decodingFailed(reason: error.localizedDescription)
            case .keyNotFound(let codingKey, let context):
                print("Key \(codingKey) is not found in the \(context.debugDescription)")
                throw DictionaryError.decodingFailed(reason: error.localizedDescription)
            case .dataCorrupted(let context):
                print("Data is corrupted for \(context.debugDescription)")
                throw DictionaryError.decodingFailed(reason: context.debugDescription)
            default:
                print("Unknown error occurred: \(error.localizedDescription)")
                throw DictionaryError.decodingFailed(reason: error.localizedDescription)
            }
        } catch {
            print("Unknown error occurred while fetching the data: \(error)")
            if let error = error as? DictionaryError {
                throw error
            } else {
                throw .invalidURL
            }
        }
    }
}
