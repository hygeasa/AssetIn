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
                    Text("home")
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
        }
    }


#Preview {
    ContentView()
}
