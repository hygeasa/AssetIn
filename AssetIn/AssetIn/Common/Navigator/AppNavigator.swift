//
//  AppNavigator.swift
//  AssetIn
//
//  Created by Hygea Saveria on 28/10/23.
//

import SwiftUI

final class AppNavigator: ObservableObject {
    
    @Published var routes: [Route] = []
    
    func navigate(to view: Route) {
        routes.append(view)
    }
    
    func back() {
        _ = routes.popLast()
    }
    
    func backHome() {
        routes = []
    }
}

enum Route {
    case login(LoginViewModel, AppNavigator)
}

extension Route: View {
    var body: some View {
        switch self {
        case .login(let viewModel, let navigator):
            LoginView(viewModel: viewModel, navigator: navigator)
      
        }
    }
}

extension Route: Hashable {
    static func == (lhs: Route, rhs: Route) -> Bool {
        return true
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
}
