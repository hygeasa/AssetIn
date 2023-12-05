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
    case home(HomeViewModel, AppNavigator)
    case main(AppNavigator)
    case search(SearchViewModel, AppNavigator)
    case history(HistoryViewModel, AppNavigator)
    case ongoing(OnGoingViewModel, AppNavigator)
    case notification(NotificationViewModel, AppNavigator)
}

extension Route: View {
    var body: some View {
        switch self {
        case .login(let viewModel, let navigator):
            LoginView(viewModel: viewModel, navigator: navigator)
        case.home(let viewModel, let navigator):
            HomeView(viewModel: viewModel, navigator: navigator)
        case.main(let navigator):
            MainView(navigator: navigator)
        case.search(let viewModel, let navigator):
            SearchView(viewModel: viewModel, navigator: navigator)
        case.history(let viewModel, let navigator):
            HistoryView(viewModel: viewModel, navigator: navigator)
        case.ongoing(let viewModel, let navigator):
            OnGoingView(viewModel: viewModel, navigator: navigator)
        case.notification(let viewModel, let navigator):
            NotificationView(viewModel: viewModel, navigator: navigator)
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
