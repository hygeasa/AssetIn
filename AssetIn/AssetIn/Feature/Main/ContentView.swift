//
//  ContentView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 28/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var navigator: AppNavigator = .init()
    @AppStorage("LOGIN_STATUS") private var loginStatus: Int = 0
    
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
