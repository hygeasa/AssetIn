//
//  FindReportView.swift
//  AssetIn
//
//  Created by Hygea Saveria on 17/12/23.
//

import SwiftUI

struct FindReportView: View {
    
    @ObservedObject var viewModel : FindReportViewModel
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
                Text("Find Report")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
                Image.logoAssetin
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            ScrollView{
                Text(viewModel.date)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    .padding(.horizontal, 30)
                
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
                                .padding(.vertical, 5)
                            
                            HStack {
                                Button {
                                    
                                }label : {
                                    Text("Accept")
                                        .foregroundColor(.white)
                                        .font(.system(size :10, weight: .bold))
                                        .padding(.vertical, 5)
                                        .padding(.horizontal, 50)
                                        .background(Color.AssetIn.green)
                                        .cornerRadius(10)
                                }
                                
                                Text("Deadline: \(viewModel.deadline)")
                                    .font(.system(size: 10,weight: .bold))
                                    .foregroundColor(.AssetIn.orange)
                                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
                            }
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
                                navigator .navigate(to: .search(.init(), navigator))
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
    FindReportView(viewModel: .init(), navigator: .init())
}
