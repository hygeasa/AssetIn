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
                VStack {
                    ForEach(0...1, id:\.self) { index in
                        VStack(alignment: .leading, spacing: 5){
                            Text("On process")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .medium))
                                .padding(6)
                                .padding(.horizontal)
                                .background(Color.AssetIn.orange)
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
                VStack {
                    ForEach(0...1, id:\.self) { index in
                        VStack(alignment: .leading, spacing: 5){
                            Text("On going")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .medium))
                                .padding(6)
                                .padding(.horizontal)
                                .background(Color.AssetIn.purple)
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
                VStack {
                    ForEach(0...1, id:\.self) { index in
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
                            
                            Button {
                            }label: {
                                Text("Lend again")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(6)
                                    .background(Color.AssetIn.orange)
                                    .cornerRadius(15)
                                    .shadow(color: .black.opacity(0.1), radius: 5)
                                    
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal)
                            
                            
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
    OnGoingView(viewModel: .init(), navigator: .init())
}
