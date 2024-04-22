//
//  DefaultEmptyView.swift
//  AssetIn
//
//  Created by Irham Naufal on 22/04/24.
//

import SwiftUI

struct DefaultEmptyView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("🙏🏻")
                .font(.system(size: 70))
            
            Text("There's no data here..")
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    DefaultEmptyView()
}
