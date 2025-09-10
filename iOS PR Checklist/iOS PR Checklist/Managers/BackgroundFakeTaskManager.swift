//
//  BackgroundFakeTaskManager.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 10.09.2025.
//

import Foundation
import Observation

protocol BackgroundTaskManager {
    var resultConcurrency: String { get }
    @discardableResult
    func startFakeBackgroundTaskConcurrency() -> Task<Void, Never>
}

@Observable
class BackgroundFakeTaskManager: BackgroundTaskManager {
    var resultConcurrency: String = "No result yet"
    
    // MARK: - Swift Concurrency version
    @discardableResult
    func startFakeBackgroundTaskConcurrency() -> Task<Void, Never> {
        let task = Task { [weak self] in
            self?.log("🔵 Concurrency: started background work")
            precondition(!Thread.isMainThread, "Expensive work should not run on the MAIN thread")
            _ = self?.doExpensiveCPUWork()
            // Simulate background work
            try? await Task.sleep(nanoseconds: 2 * 1_000_000_000)
            let data = "✅ Concurrency: finished background work"
            self?.applyResult(data)
        }
        return task
    }
    
    @MainActor
    private func applyResult(_ data: String) {
        log("🟢 Concurrency: updating UI")
        resultConcurrency = data
    }
    
    // MARK: - CPU-bound simulation (for demo purposes)
    private func doExpensiveCPUWork() -> Int {
        var acc = 0
        for i in 0..<5_000_000 { acc &+= i }
        return acc
    }
    
    // MARK: - Logging helper
    private func log(_ message: String) {
        print("\(message) — \(Thread.isMainThread ? "MAIN" : "BACKGROUND")")
    }
}
