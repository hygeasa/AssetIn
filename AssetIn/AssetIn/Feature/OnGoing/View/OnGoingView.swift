//
//  OnGoingView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 01/12/23.
//

import SwiftUI

struct OnGoingView: View {
    @ObservedObject var viewModel: OnGoingViewModel
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
                Text("On Going")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Image.imageProfile
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
            }
            .padding(.horizontal)
            
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.historyData, id:\.id) { item in
                        VStack(alignment: .leading, spacing: 5){
                            Text(item.status ?? "–")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .medium))
                                .padding(6)
                                .padding(.horizontal)
                                .background(Color.AssetIn.orange)
                                .cornerRadius(15)
                            
                            Text(item.inventoryName ?? "–")
                                .font(.system(size: 15, weight: .regular))
                            
                            Text("Category: \((item.categoryId ?? "–").capitalized)")
                                .font(.system(size: 12, weight: .semibold))
                            
                            Text("Requested: \((item.requestedAt ?? .now).toString(format: .withSlash))")
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.AssetIn.greyText)
                            
                            Group {
                                if let expiredAt = item.expiredAt {
                                    Text("Deadline: \((expiredAt).toString(format: .withSlash))")
                                } else {
                                    Text("–")
                                }
                            }
                            .font(.system(size: 10,weight: .bold))
                            .foregroundColor(.AssetIn.orange)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                    }
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
        .onAppear {
            viewModel.getHistoryData()
        }
    }
}

#Preview {
    OnGoingView(viewModel: .init(), navigator: .init())
}
