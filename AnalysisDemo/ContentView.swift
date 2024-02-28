//
//  ContentView.swift
//  AnalysisDemo
//
//  Created by liang wang on 28/2/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Track demo") {
                Analysis.logDemo()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
