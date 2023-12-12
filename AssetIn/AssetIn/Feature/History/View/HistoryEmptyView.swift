//
//  HistoryEmptyView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 11/12/23.
//

import SwiftUI

struct HistoryEmptyView: View {
    var body: some View {
        VStack(spacing:3) {
            Image.logoWink
                .resizable()
                .scaledToFit()
                .frame(width: 150)
            
            Text("You don't have any history yet.")
                .font(.system(size: 20, weight: .medium))
                .shadow(color: .black.opacity(0.1), radius: 5)
                .multilineTextAlignment(.center)
                .frame(width: 150)
                .padding()
            
            HStack(spacing: 5){
                Text("You can start borrow")
                    .font(.system(size: 12, weight: .regular))
                Button {
                    
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
    HistoryEmptyView()
}
