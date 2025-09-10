//
//  BackgroundTaskView.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 10.09.2025.
//

import SwiftUI

struct BackgroundTaskView: View {
    @State private var viewModel = BackgroundFakeTaskManager()

    var body: some View {
        VStack(spacing: 24) {
            Group {
                Text("Swift Concurrency").font(.headline)
                Text(viewModel.resultConcurrency)
                Button("Start Concurrency Task") {
                    viewModel.startFakeBackgroundTaskConcurrency()
                }
            }
        }
        .padding()
    }
}
