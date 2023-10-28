//
//  SampleView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 28/10/23.
//

import SwiftUI

class SampleViewModel: ObservableObject {
    
}

struct SampleView: View {
    
    @ObservedObject var viewModel: SampleViewModel
    @ObservedObject var navigator: AppNavigator
    
    var body: some View {
        Button("BALEEEEKK") {
            navigator.back()
        }
        
        Button("ke dummy") {
            navigator.navigate(to: .dummy(.init(), navigator))
        }
    }
}

#Preview {
    SampleView(viewModel: .init(), navigator: .init())
}
