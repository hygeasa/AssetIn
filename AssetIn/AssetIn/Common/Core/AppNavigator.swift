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
    case main(AppNavigator)
    case history(HistoryViewModel)
}

extension Route: View {
    var body: some View {
        switch self {
        case .login(let viewModel, let navigator):
            LoginView(viewModel: viewModel, navigator: navigator)
        case .main(let navigator):
            MainView(navigator: navigator)
        case .history(let viewModel):
            HistoryView(viewModel: viewModel)
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
