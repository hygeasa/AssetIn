//
//  MainView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 30/11/23.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var navigator: AppNavigator
    var body: some View {
        TabView {
            HomeView(viewModel: .init(), navigator: navigator)
                .tabItem {
                    Image(systemName: "house")
                    Text("home")
                }
            NotificationView(viewModel: .init(), navigator: navigator)
                .tabItem {
                    Image(systemName: "bell")
                    Text("notification")
                }
            ProfileView(viewModel: .init(), navigator: navigator)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
            
            
        }
        .tint(.AssetIn.orange)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        }
    }


#Preview {
    ContentView()
}
