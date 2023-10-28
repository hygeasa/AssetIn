//
//  ContentView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 28/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var navigator: AppNavigator = .init()
    
    var body: some View {
        NavigationStack(path: $navigator.routes) {
            OnboardingView(navigator: navigator)
                .navigationDestination(for: Route.self, destination: { $0 })
        }
    }
}

#Preview {
    ContentView()
}
