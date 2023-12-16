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
            HStack {
                Button {
                    navigator.back()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                Text("What are you looking for?")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
                Image.logoAssetin
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            .padding(.horizontal)
            
            VStack(spacing: 2){
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(.AssetIn.greyText)
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                
                ScrollView {
                    VStack(spacing: 5) {
                        ForEach(viewModel.data, id: \.id) { item in
                            ExpandedSessionView(inventory: item)
                        }
                    }
                    .padding()
                }
            }
        }
        .background(
            VStack {
                RadialGradient(
                    gradient: Gradient(colors: [Color.orange, Color.yellow]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 200
                )
                .frame(height: 130)
                .edgesIgnoringSafeArea(.all)
                .cornerRadius(15)
                Spacer()
            }
                .ignoresSafeArea()
        )
        .background(Color.AssetIn.grey.ignoresSafeArea())
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    EditDataView(viewModel: .init(), navigator: .init())
}
