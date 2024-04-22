//
//  MainView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 30/11/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var navigator: AppNavigator
    @StateObject var settings = SystemSettings.shared
    
    var body: some View {
        TabView(selection: $settings.mainTabSelection) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(MainTabSelection.home)
            
            HistoryView()
                .tabItem {
                    Image(systemName: settings.isStudent ? "clock.arrow.circlepath" : "list.bullet.clipboard")
                    Text(settings.isStudent ? "History" : "Loans")
                }
                .tag(MainTabSelection.history)
            
            Text("Profile")
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(MainTabSelection.profile)
        }
        .tint(.AssetIn.orange)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .onAppear {
            UITabBar.appearance().backgroundColor = .white
            UITabBar.appearance().isTranslucent = false
        }
    }
}


#Preview {
    ContentView()
}
