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
    case profile(ProfileViewModel, AppNavigator)
    case changepassword(ChangePasswordViewModel, AppNavigator)
    case changeprofile(ChangeProfileViewModel, AppNavigator)
    case take(TakeViewModel, AppNavigator)
    case searchdetail(SearchDetailViewModel, AppNavigator)
    case editdata(EditDataViewModel, AppNavigator)
    case editItem(EditItemViewModel, AppNavigator)
    
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
        case.profile(let viewModel, let navigator):
            ProfileView(viewModel: viewModel, navigator: navigator)
        case.changepassword(let viewModel, let navigator):
            ChangePasswordView(viewModel: viewModel, navigator: navigator)
        case.changeprofile(let viewModel, let navigator):
            ChangeProfileView(viewModel: viewModel, navigator: navigator)
        case.take(let viewModel, let navigator):
            TakeView(viewModel: viewModel, navigator: navigator)
        case.searchdetail(let viewModel, let navigator):
            SearchDetailView(viewModel: viewModel, navigator: navigator)
        case.editdata(let viewModel, let navigator):
            EditDataView(viewModel: viewModel, navigator: navigator)
        case.editItem(let viewModel, let navigator):
            EditItemView(viewModel: viewModel, navigator: navigator)
                    
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
