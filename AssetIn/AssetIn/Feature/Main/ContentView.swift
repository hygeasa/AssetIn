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
        ZStack {
            Color.white.ignoresSafeArea()
            if loginStatus == 0 {
                NavigationStack(path: $navigator.routes) {
                    OnboardingView(navigator: navigator)
                        .navigationDestination(for: Route.self, destination: { $0 })
                }
            } else {
                NavigationStack(path: $navigator.routes) {
                    MainView(navigator: navigator)
                        .navigationDestination(for: Route.self, destination: { $0 })
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
