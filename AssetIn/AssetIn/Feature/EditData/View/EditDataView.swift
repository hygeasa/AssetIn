//
//  EditDataView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 13/12/23.
//

import SwiftUI

struct EditDataView: View {
    
    @ObservedObject var viewModel : EditDataViewModel
    @ObservedObject var navigator : AppNavigator
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(.AssetIn.greyText)
                .padding(.horizontal)
            
            ScrollView {
                VStack {
                    ForEach(viewModel.data, id: \.id) { item in
                        ExpandedSessionView(inventory: item)
                    }
                }
                .padding()
            }
        }
        .background(Color.AssetIn.grey.ignoresSafeArea())
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    EditDataView(viewModel: .init(), navigator: .init())
}
