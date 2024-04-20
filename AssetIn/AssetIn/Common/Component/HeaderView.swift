//
//  HeaderView.swift
//  AssetIn
//
//  Created by Irham Naufal on 20/04/24.
//

import SwiftUI

struct HeaderView<LeadingContent: View>: View {
    
    private let leading: () -> LeadingContent
    
    init(@ViewBuilder leading: @escaping () -> LeadingContent = { EmptyView() }) {
        self.leading = leading
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            RadialGradient(
                gradient: Gradient(colors: [Color.orange, Color.yellow]),
                center: .center,
                startRadius: 0,
                endRadius: 200
            )
            .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
            .ignoresSafeArea()
            
            leading()
                .padding()
                .padding(.bottom, 8)
        }
        .frame(height: 58)
    }
}

#Preview {
    VStack(spacing: 0) {
        HeaderView {
            HStack {
                Image(systemName: "chevron.left")
                Text("Home")
            }
            .foregroundColor(.white)
            .font(.headline)
        }
        ScrollView {
            Text("Halo")
        }
    }
    .navigationTitle("")
    .navigationBarBackButtonHidden()
}
