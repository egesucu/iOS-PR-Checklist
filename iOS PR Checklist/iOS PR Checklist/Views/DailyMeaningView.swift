//
//  DailyMeaningView.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 30.08.2025.
//

import SwiftUI

struct DailyMeaningView: View {
    
    enum MeaningState {
        case loading
        case loaded([MeaningModel])
        case error(DictionaryError)
    }
    
    var searchTerm: String
    @State private var viewState: MeaningState = .loading
    
    let manager: DictionaryManager = DictionaryManagerImplementation.shared
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                switch viewState {
                case .loading:
                    Text("Searching for \(searchTerm)")
                        .bold()
                        .accessibilityIdentifier("daily_title_loading")
                default:
                    Text("Searched for \(searchTerm)")
                        .bold()
                        .accessibilityIdentifier("daily_title_loaded")
                }
                Spacer()
            }
            
           
            resultView
        }
        .padding()
        .task {
            try? await Task.sleep(nanoseconds: 10_000_000_000)
            do {
                let models = try await manager.fetchWord(searchTerm: searchTerm)
                self.viewState = .loaded(models)
            } catch let error as DictionaryError {
                self.viewState = .error(error)
            } catch {
                self.viewState = .error(.invalidURL)
            }
        }
    }
    
    @ViewBuilder var resultView: some View {
        switch viewState {
        case .loading:
            ProgressView()
                .accessibilityIdentifier("daily_progress")
        case .loaded(let models):
            if let firstModel = models.first,
               let firstMeaning = firstModel.meanings.first {
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(firstMeaning.definitions, id: \.self) { definition in
                            definitionView(definition.content)
                                .accessibilityIdentifier("daily_definition_item")
                        }
                        if let sourceURL = firstModel.sourceURLS.first {
                            Text("Source: \(sourceURL)")
                                .accessibilityIdentifier("daily_source")
                        }
                    }
                    .accessibilityIdentifier("daily_definitions")
                }
            } else {
                EmptyView()
            }
        case .error(let error):
            errorView(error: error)
        }
    }
    
    func definitionView(_ content: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.2))
            Text(content)
                .padding()
        }
    }
    
    @ViewBuilder
    func errorView(error: DictionaryError) -> some View {
        switch error {
        case .decodingFailed(reason: let reason):
            Text(reason)
                .foregroundStyle(.red)
                .accessibilityIdentifier("daily_error_message")
        case .networkIssue(details: let details):
            Text(details)
                .foregroundStyle(.red)
                .accessibilityIdentifier("daily_error_message")
        case .wordNotFound(title: let title, resolution: let resolution):
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .foregroundStyle(.red)
                    .accessibilityIdentifier("daily_error_title")
                Text(resolution)
                    .foregroundStyle(.yellow)
                    .accessibilityIdentifier("daily_error_resolution")
            }
        case .invalidURL:
            Text("The URL is invalid")
                .foregroundStyle(.red)
                .accessibilityIdentifier("daily_error_message")
        }
    }
}

#Preview("Successful Fetch") {
    let successSearch = "Holly"
    return DailyMeaningView(searchTerm: successSearch)
}

#Preview("Error Fetch") {
    let errorSearch = "avefs"
    return DailyMeaningView(searchTerm: errorSearch)
}
