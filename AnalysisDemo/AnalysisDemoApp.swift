//
//  AnalysisDemoApp.swift
//  AnalysisDemo
//
//  Created by liang wang on 28/2/2024.
//

import SwiftUI

@main
struct AnalysisDemoApp: App {
    
    init() {
        Analysis.initTracking()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
