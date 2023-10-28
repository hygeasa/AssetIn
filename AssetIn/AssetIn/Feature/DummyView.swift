//
//  DummyView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 28/10/23.
//

import SwiftUI

class DummyViewModel: ObservableObject {
    
}

struct DummyView: View {
    
    @ObservedObject var viewModel: DummyViewModel
    @ObservedObject var navigator: AppNavigator
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button(action: {
            navigator.backHome()
        }, label: {
            Text("Back Home")
        })
    }
}

#Preview {
    DummyView(viewModel: .init(), navigator: .init())
}
