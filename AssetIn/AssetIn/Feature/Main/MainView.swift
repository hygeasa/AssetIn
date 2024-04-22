//
//  MainView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 30/11/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var navigator: AppNavigator
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            Text("Profile")
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
            
            
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
