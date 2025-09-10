//
//  iOS_PR_ChecklistApp.swift
//  iOS PR Checklist
//
//  Created by Sucu, Ege on 27.08.2025.
//

import SwiftUI

@main
struct ChecklistApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

struct RootView: View {
    var body: some View {
        if ProcessInfo.processInfo.arguments.contains("-UITest_ListView_DemoData") {
            // Always show ListView with demo items
            ListView(imaginaryData: Item.demoItems)
        } else {
            // Your normal app flow
            NavigationStack {
                ListView(imaginaryData: [])
            }
        }
    }
}
