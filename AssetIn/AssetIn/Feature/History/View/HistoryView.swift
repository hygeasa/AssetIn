//
//  HistoryView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 30/11/23.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel : HistoryViewModel
    @ObservedObject var navigator : AppNavigator
    
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
                Text("History")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Image.imageProfile
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
            }
            .padding(.horizontal)
//            if viewModel.data.isEmpty {
//                HistoryEmptyView()
//            } else {
            ScrollView {
                VStack {
                    ForEach(0...10, id:\.self) { index in
                        VStack(alignment: .leading, spacing: 5){
                            Text("Done")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .medium))
                                .padding(6)
                                .padding(.horizontal)
                                .background(Color.AssetIn.green)
                                .cornerRadius(15)
                            
                            Text(viewModel.inventory)
                                .font(.system(size: 15, weight: .regular))
                            
                            Text("Category: \(viewModel.category)")
                                .font(.system(size: 12, weight: .semibold))
                            
                            Text(viewModel.lending)
                                .font(.system(size: 10, weight: .medium))
                                .foregroundColor(.AssetIn.greyText)
                            
                            Text("Deadline: \(viewModel.deadline)")
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
    }
}

#Preview {
    HistoryView(viewModel: .init(), navigator: .init())
}
