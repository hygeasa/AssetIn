//
//  TakeEmptyView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 12/12/23.
//

import SwiftUI

struct TakeEmptyView: View {
    @ObservedObject  var navigator : AppNavigator
    
    var body: some View {
        VStack(spacing:3) {
            Image.logoWink
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            
            Text("You don't have any stuff yet.")
                .font(.system(size: 20, weight: .medium))
                .shadow(color: .black.opacity(0.1), radius: 5)
                .multilineTextAlignment(.center)
                .frame(width: 150)
                .padding()
            
            HStack(spacing: 5){
                Text("You can start borrow")
                    .font(.system(size: 12, weight: .regular))
                Button {
                    navigator.navigate(to: .search(.init(), navigator))
                }label: {
                    Text("here")
                        .font(.system(size: 12, weight: .regular))
                        .underline()
                        .foregroundColor(.AssetIn.orange)
                    
                }
            }
            
        }
    }
}

#Preview {
    TakeEmptyView(navigator: .init())
}
