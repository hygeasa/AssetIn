//
//  TakeView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 12/12/23.
//

import SwiftUI
struct TakeView: View {
    
    @ObservedObject var viewModel: TakeViewModel
    @ObservedObject var navigator: AppNavigator
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    navigator.back()
                }label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(.white)
                }
                Text("Take")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Image.imageProfile
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
            }
            .padding(.horizontal)
            
            Group {
                if viewModel.data.isEmpty {
                    TakeEmptyView(navigator: navigator)
                } else {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(0...2, id:\.self) { index in
                                VStack(alignment: .leading, spacing: 5){
                                    
                                    Text(viewModel.inventory)
                                        .font(.system(size: 15, weight: .regular))
                                    
                                    Text("Category: \(viewModel.category)")
                                        .font(.system(size: 12, weight: .semibold))
                                    
                                    HStack(spacing: 1){
                                        Text("You can take your stuff here : ")
                                            .font(.system(size: 10, weight: .medium))
                                            .foregroundColor(.AssetIn.greyText)
                                        Text(viewModel.place)
                                            .font(.system(size: 10, weight: .medium))
                                            .foregroundColor(.AssetIn.greyText)
                                    }
                                    
                                    
                                    Text("Deadline: \(viewModel.deadline)")
                                        .font(.system(size: 10,weight: .bold))
                                        .foregroundColor(.AssetIn.orange)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(15)
                                .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    TakeView(viewModel: .init(), navigator: .init())
}
