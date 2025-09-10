//
//  MockBackgroundTaskManager.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 10.09.2025.
//

import Foundation
@testable import iOS_PR_Checklist

final class MockBackgroundTaskManager: BackgroundTaskManager {
    var resultConcurrency: String = ""
        
    @discardableResult
    func startFakeBackgroundTaskConcurrency() -> Task<Void, Never> {
        let task = Task { [weak self] in
            // Simulate background work
            try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            let data = "✅ Concurrency: finished background work"
            self?.applyResult(data)
        }
        return task
    }
    
    @MainActor
    private func applyResult(_ data: String) {
        self.resultConcurrency = data
    }
}
