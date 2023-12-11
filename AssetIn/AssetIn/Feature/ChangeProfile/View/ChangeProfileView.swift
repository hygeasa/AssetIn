//
//  ChangeProfileView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 11/12/23.
//

import SwiftUI
struct ChangeProfileView: View {
    @ObservedObject var viewModel : ChangeProfileViewModel
    @ObservedObject var navigator : AppNavigator
    
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    ChangeProfileView(viewModel: .init(), navigator: .init())
}
